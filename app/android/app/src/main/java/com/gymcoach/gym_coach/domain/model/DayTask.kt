package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import java.time.LocalDate

/**
 * Mirrors `lib/domain/models/day_task.dart`. Stored split across several DB
 * fields (`workout_json`, `meals_json`, `completed_workout`, etc.) — the
 * composite shape is only held in memory. `dbId` is null when a task is
 * fabricated in memory (not yet persisted).
 */
data class DayTask(
    val dbId: Int? = null,
    val planId: Int,
    val dayIndex: Int,
    val date: LocalDate,
    val workout: Workout? = null,
    val meals: List<Meal> = emptyList(),
    val completedWorkout: Boolean = false,
    val completedMeals: Map<String, Boolean> = emptyMap(),
    @SerialName("xp_awarded") val xpAwarded: Int = 0,
    val completedAt: Long? = null
)
