package com.gymcoach.gym_coach.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class ChatMessage(
    @SerialName("plan_id") val planId: Int,
    val role: ChatRole,
    val content: String,
    @SerialName("created_at") val createdAt: Long
)
