package com.gymcoach.gym_coach.feature.today

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gymcoach.gym_coach.data.repository.DayTaskRepository
import com.gymcoach.gym_coach.data.repository.GamificationRepository
import com.gymcoach.gym_coach.data.repository.PlanRepository
import com.gymcoach.gym_coach.domain.model.DayTask
import com.gymcoach.gym_coach.gamification.XpEngine
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import java.time.LocalDate
import javax.inject.Inject

sealed interface TodayUiState {
    data object Loading : TodayUiState
    data object Empty : TodayUiState
    data class Loaded(val task: DayTask) : TodayUiState
}

@HiltViewModel
class TodayViewModel @Inject constructor(
    private val planRepo: PlanRepository,
    private val taskRepo: DayTaskRepository,
    private val gamifRepo: GamificationRepository
) : ViewModel() {

    private val _state = MutableStateFlow<TodayUiState>(TodayUiState.Loading)
    val state: StateFlow<TodayUiState> = _state.asStateFlow()

    fun load() {
        viewModelScope.launch {
            _state.value = TodayUiState.Loading
            val stored = planRepo.getActive()
            if (stored == null) {
                _state.value = TodayUiState.Empty
                return@launch
            }
            val today = taskRepo.getByDate(stored.id, LocalDate.now())
            _state.value = if (today == null) TodayUiState.Empty else TodayUiState.Loaded(today)
        }
    }

    /** Returns the XP awarded (or null if the task was already done). */
    fun completeWorkout(task: DayTask, onXp: (Int) -> Unit) {
        viewModelScope.launch {
            val id = task.dbId ?: return@launch
            if (task.completedWorkout) return@launch
            val allMealsDone = task.completedMeals.values.all { it } && task.completedMeals.isNotEmpty()
            val award = XpEngine.computeXpForWorkoutCompletion(allMealsDone)
            taskRepo.markWorkoutDone(id)
            taskRepo.awardXp(id, award.xp)
            gamifRepo.recordEvent("WORKOUT_DONE", award.xp)
            onXp(award.xp)
            load()
        }
    }

    /** Returns the XP awarded (or null if the task was already done). */
    fun completeMeal(task: DayTask, slot: String, onXp: (Int) -> Unit) {
        viewModelScope.launch {
            val id = task.dbId ?: return@launch
            if (task.completedMeals[slot] == true) return@launch
            val before = task.completedMeals.size
            val total = task.meals.size
            val award = XpEngine.computeXpForMealCompletion(mealsCompletedBefore = before, totalMeals = total)
            taskRepo.markMealDone(id, slot, true)
            if (award.xp > 0) {
                taskRepo.awardXp(id, award.xp)
                gamifRepo.recordEvent("MEAL_DONE", award.xp)
            }
            onXp(award.xp)
            load()
        }
    }
}
