package com.gymcoach.gym_coach.domain.model

/** `PlanRepository.getActive()` return type. */
data class StoredPlan(
    val id: Int,
    val plan: Plan
)
