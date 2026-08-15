package com.gymcoach.gym_coach.data.db.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.gymcoach.gym_coach.data.db.entity.ChatMessageEntity

@Dao
interface ChatMessageDao {
    @Insert
    suspend fun insert(message: ChatMessageEntity): Long

    @Query("SELECT * FROM chat_messages WHERE plan_id = :planId ORDER BY created_at ASC")
    suspend fun forPlan(planId: Long): List<ChatMessageEntity>
}
