package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class DailyMeals(
    val week: Int,
    @SerialName("day_of_week") val dayOfWeek: Int,
    @SerialName("total_kcal") val totalKcal: Int,
    @SerialName("protein_g") val proteinG: Int,
    @SerialName("carbs_g") val carbsG: Int,
    @SerialName("fat_g") val fatG: Int,
    val meals: List<Meal>
)
