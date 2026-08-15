package com.gymcoach.gym_coach.feature.onboarding

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gymcoach.gym_coach.data.network.dto.MessageDto
import com.gymcoach.gym_coach.data.repository.PlanRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class OnboardingUiState(
    val messages: List<OnboardingMessage> = emptyList(),
    val busy: Boolean = false,
    val planCreated: Boolean = false
)

data class OnboardingMessage(val role: String, val text: String)

@HiltViewModel
class OnboardingViewModel @Inject constructor(
    private val controller: OnboardingController,
    private val planRepo: PlanRepository
) : ViewModel() {

    private val _state = MutableStateFlow(OnboardingUiState())
    val state: StateFlow<OnboardingUiState> = _state.asStateFlow()

    private val history = mutableListOf<MessageDto>()

    fun send(userText: String, onPlanCreated: (Int) -> Unit) {
        if (userText.isBlank() || _state.value.busy || _state.value.planCreated) return
        _state.update {
            it.copy(
                messages = it.messages + OnboardingMessage(role = "user", text = userText),
                busy = true
            )
        }
        history.add(MessageDto("user", userText))
        viewModelScope.launch {
            val accumulated = StringBuilder()
            controller.sendMessage(userText, history.dropLast(1)).collect { chunk ->
                accumulated.append(chunk)
                _state.update { state ->
                    val msgs = state.messages.toMutableList()
                    val lastAssistantIdx = msgs.indexOfLast { it.role == "assistant" }
                    if (lastAssistantIdx >= 0) {
                        msgs[lastAssistantIdx] = OnboardingMessage("assistant", accumulated.toString())
                    } else {
                        msgs.add(OnboardingMessage("assistant", accumulated.toString()))
                    }
                    state.copy(messages = msgs)
                }
                controller.tryExtractPlan(accumulated.toString())?.let { plan ->
                    if (!_state.value.planCreated) {
                        planRepo.deactivateAll()
                        val planId = planRepo.create(plan)
                        _state.update { it.copy(planCreated = true) }
                        onPlanCreated(planId)
                    }
                }
            }
            history.add(MessageDto("assistant", accumulated.toString()))
            _state.update { it.copy(busy = false) }
        }
    }
}
