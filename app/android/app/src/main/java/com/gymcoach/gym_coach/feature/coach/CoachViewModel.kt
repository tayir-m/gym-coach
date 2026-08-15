package com.gymcoach.gym_coach.feature.coach

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gymcoach.gym_coach.data.network.LlmClient
import com.gymcoach.gym_coach.data.network.dto.MessageDto
import com.gymcoach.gym_coach.data.repository.ChatRepository
import com.gymcoach.gym_coach.data.repository.PlanRepository
import com.gymcoach.gym_coach.domain.model.ChatMessage
import com.gymcoach.gym_coach.domain.model.ChatRole
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class CoachUiState(
    val messages: List<ChatMessage> = emptyList(),
    val planId: Int? = null,
    val busy: Boolean = false
)

/** Convert ChatRole to the lowercase string the LLM expects. */
private fun ChatRole.toWire(): String = name.lowercase()

@HiltViewModel
class CoachViewModel @Inject constructor(
    private val llmClient: LlmClient,
    private val chatRepo: ChatRepository,
    private val planRepo: PlanRepository
) : ViewModel() {

    private val _state = MutableStateFlow(CoachUiState())
    val state: StateFlow<CoachUiState> = _state.asStateFlow()

    fun load() {
        viewModelScope.launch {
            val active = planRepo.getActive()
            _state.update { it.copy(planId = active?.id) }
            if (active != null) {
                val history = chatRepo.getForPlan(active.id)
                _state.update { it.copy(messages = history) }
            }
        }
    }

    /**
     * Mirrors the Flutter app: the entire stream is buffered into one string,
     * then the assistant message is persisted + appended. NO incremental UI
     * update — this differs intentionally from `OnboardingViewModel`.
     */
    fun send(userText: String) {
        val pid = _state.value.planId ?: return
        if (userText.isBlank() || _state.value.busy) return
        viewModelScope.launch {
            _state.update { it.copy(busy = true) }
            val now = System.currentTimeMillis()
            val userMsg = ChatMessage(planId = pid, role = ChatRole.User, content = userText, createdAt = now)
            chatRepo.add(userMsg)
            val allMessages = _state.value.messages + userMsg
            _state.update { it.copy(messages = allMessages) }

            val history = allMessages
                .filter { it.role != ChatRole.System }
                .map { MessageDto(it.role.toWire(), it.content) }
            val buffer = StringBuilder()
            llmClient.chat(messages = history).collect { buffer.append(it) }
            val reply = buffer.toString()
            val assistantMsg = ChatMessage(planId = pid, role = ChatRole.Assistant, content = reply, createdAt = System.currentTimeMillis())
            chatRepo.add(assistantMsg)
            _state.update {
                it.copy(
                    messages = it.messages + assistantMsg,
                    busy = false
                )
            }
        }
    }
}
