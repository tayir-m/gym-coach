package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Exercise(
    val name: String,
    val sets: Int,
    val reps: String,
    @SerialName("rest_seconds") val restSeconds: Int = 90,
    val notes: String? = null
)
