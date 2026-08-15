package com.gymcoach.gym_coach.data.db.dao

import androidx.room.Dao
import androidx.room.Insert
import com.gymcoach.gym_coach.data.db.entity.GamificationEventEntity

@Dao
interface GamificationEventDao {
    @Insert
    suspend fun insert(event: GamificationEventEntity): Long
}
