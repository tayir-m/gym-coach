package com.gymcoach.gym_coach.data.network.dto

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class MessageDto(val role: String, val content: String)

@Serializable
data class ChatRequestDto(
    val messages: List<MessageDto>,
    val temperature: Double = 0.7,
    val model: String? = null
)

@Serializable
data class ChatDeltaDto(
    @SerialName("delta") val delta: String? = null
)
