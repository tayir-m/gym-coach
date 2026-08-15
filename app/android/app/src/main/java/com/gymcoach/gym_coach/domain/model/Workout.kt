package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** In-memory representation of a day's workout. The DB stores its JSON form. */
@Serializable
data class Workout(
    val title: String,
    @SerialName("estimated_minutes") val estimatedMinutes: Int,
    val exercises: List<Exercise>
)
