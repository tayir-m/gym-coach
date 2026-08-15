package com.gymcoach.gym_coach.domain.model

import java.time.LocalDate

/** In-memory shape for the singleton `streaks` row. */
data class StreakData(
    val currentDays: Int = 0,
    val longestDays: Int = 0,
    val lastActiveDate: LocalDate? = null,
    val freezesRemaining: Int = 2
)
