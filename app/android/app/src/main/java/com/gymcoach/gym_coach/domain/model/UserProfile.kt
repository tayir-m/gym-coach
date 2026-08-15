package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/**
 * Mirrors `lib/domain/models/user_profile.dart`. Enums are serialized via
 * `name.toCamelCase()` style keys (`muscle_gain`, `fat_loss`, etc.) to match
 * what the LLM emits; the Flutter code used `Sex.values.byName` which
 * matched on the JSON string. Same contract here.
 */
@Serializable
data class UserProfile(
    val age: Int,
    @SerialName("height_cm") val heightCm: Double,
    @SerialName("weight_kg") val weightKg: Double,
    val sex: Sex,
    val goal: Goal,
    val experience: Experience,
    val equipment: List<String> = emptyList(),
    val injuries: String? = null,
    @SerialName("dietary_notes") val dietaryNotes: String? = null,
    @SerialName("daily_schedule") val dailySchedule: Map<String, Boolean> = emptyMap(),
    @SerialName("updated_at") val updatedAt: Long = System.currentTimeMillis()
)
