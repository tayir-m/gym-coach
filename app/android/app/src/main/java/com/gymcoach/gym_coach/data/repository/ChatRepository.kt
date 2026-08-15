package com.gymcoach.gym_coach.data.repository

import com.gymcoach.gym_coach.data.db.dao.ChatMessageDao
import com.gymcoach.gym_coach.data.db.entity.ChatMessageEntity
import com.gymcoach.gym_coach.domain.model.ChatMessage
import com.gymcoach.gym_coach.domain.model.ChatRole
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ChatRepository @Inject constructor(
    private val dao: ChatMessageDao
) {

    suspend fun getForPlan(planId: Int): List<ChatMessage> =
        dao.forPlan(planId.toLong()).map {
            ChatMessage(
                planId = planId,
                role = ChatRole.valueOf(it.role),
                content = it.content,
                createdAt = it.createdAt
            )
        }

    suspend fun add(message: ChatMessage): Long =
        dao.insert(
            ChatMessageEntity(
                planId = message.planId.toLong(),
                role = message.role.name,
                content = message.content,
                createdAt = message.createdAt
            )
        )
}
