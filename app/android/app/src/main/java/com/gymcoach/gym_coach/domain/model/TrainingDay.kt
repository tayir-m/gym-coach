package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class TrainingDay(
    val week: Int,
    @SerialName("day_of_week") val dayOfWeek: Int,
    val title: String,
    val focus: String,
    @SerialName("estimated_minutes") val estimatedMinutes: Int,
    val exercises: List<Exercise>
)
