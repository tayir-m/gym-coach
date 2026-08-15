package com.gymcoach.gym_coach.feature.profile

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gymcoach.gym_coach.data.repository.DayTaskRepository
import com.gymcoach.gym_coach.data.repository.GamificationRepository
import com.gymcoach.gym_coach.domain.model.StreakData
import com.gymcoach.gym_coach.gamification.BadgeEngine
import com.gymcoach.gym_coach.gamification.XpEngine
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class ProfileUiState(
    val streak: StreakData = StreakData(),
    val totalXp: Int = 0,
    val totalWorkoutsCompleted: Int = 0,
    val totalDaysAllMealsCompleted: Int = 0,
    val level: Int = 1,
    val xpToNext: Int = 1000,
    val unlockedBadges: List<String> = emptyList()
)

@HiltViewModel
class ProfileViewModel @Inject constructor(
    private val gamifRepo: GamificationRepository,
    private val dayTaskRepo: DayTaskRepository
) : ViewModel() {

    private val _state = MutableStateFlow(ProfileUiState())
    val state: StateFlow<ProfileUiState> = _state.asStateFlow()

    fun load() {
        viewModelScope.launch {
            val streak = gamifRepo.getStreak()
            val totalXp = gamifRepo.getTotalXp()
            val workouts = gamifRepo.getTotalWorkoutsCompleted()
            val allMealsDays = dayTaskRepo.totalDaysAllMealsCompleted()
            val level = XpEngine.levelFromXp(totalXp)
            val xpToNext = XpEngine.xpToNextLevel(totalXp)
            val badges = BadgeEngine.checkUnlockedBadges(
                mapOf(
                    "totalWorkoutsCompleted" to workouts,
                    "longestStreak" to streak.longestDays,
                    "totalDaysAllMealsCompleted" to allMealsDays,
                    "level" to level
                )
            )
            _state.update {
                it.copy(
                    streak = streak,
                    totalXp = totalXp,
                    totalWorkoutsCompleted = workouts,
                    totalDaysAllMealsCompleted = allMealsDays,
                    level = level,
                    xpToNext = xpToNext,
                    unlockedBadges = badges
                )
            }
        }
    }
}
