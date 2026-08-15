package com.gymcoach.gym_coach.feature.path

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gymcoach.gym_coach.data.repository.PlanRepository
import com.gymcoach.gym_coach.data.repository.DayTaskRepository
import com.gymcoach.gym_coach.domain.model.DayTask
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import java.time.LocalDate
import javax.inject.Inject

@HiltViewModel
class PathViewModel @Inject constructor(
    private val planRepo: PlanRepository,
    private val taskRepo: DayTaskRepository
) : ViewModel() {

    private val _state = MutableStateFlow<List<DayTask>>(emptyList())
    val state: StateFlow<List<DayTask>> = _state.asStateFlow()

    fun load() {
        viewModelScope.launch {
            val stored = planRepo.getActive() ?: run { _state.value = emptyList(); return@launch }
            _state.value = taskRepo.getAllForPlan(stored.id)
        }
    }
}
