package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/**
 * Mirrors `lib/domain/models/plan.dart`.
 *
 * Persistence contract: `startDate` is **stripped** when serializing into the
 * `plans.plan_json` column. It lives in the `start_date` column instead.
 * `PlanRepository.getActive()` re-injects an ISO string before parsing.
 */
@OptIn(ExperimentalSerializationApi::class)
@Serializable
data class Plan(
    val weeks: Int,
    @SerialName("weekly_structure") val weeklyStructure: String,
    @SerialName("goal_summary") val goalSummary: String,
    @SerialName("training_days") val trainingDays: List<TrainingDay>,
    @SerialName("daily_meals") val dailyMeals: List<DailyMeals>,
    @SerialName("start_date")
    @EncodeDefault(EncodeDefault.Mode.NEVER) val startDate: String? = null
)
