package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Meal(
    val slot: String,         // breakfast | lunch | dinner | snack
    val name: String,
    val kcal: Int,
    @SerialName("protein_g") val proteinG: Int,
    @SerialName("carbs_g") val carbsG: Int,
    @SerialName("fat_g") val fatG: Int,
    val ingredients: List<String> = emptyList()
)
