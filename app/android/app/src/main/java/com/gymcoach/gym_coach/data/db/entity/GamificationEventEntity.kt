package com.gymcoach.gym_coach.data.db.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "gamification_events")
data class GamificationEventEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0L,
    @ColumnInfo(name = "event_type") val eventType: String,
    val value: Int,
    @ColumnInfo(name = "created_at") val createdAt: Long
)
