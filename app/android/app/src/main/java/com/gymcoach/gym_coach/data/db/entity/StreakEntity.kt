package com.gymcoach.gym_coach.data.db.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Singleton row. `getStreak()` lazy-inserts a defaults row on first read.
 * `updateStreak` runs an unconditional UPDATE (matches the Flutter app).
 */
@Entity(tableName = "streaks")
data class StreakEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0L,
    @ColumnInfo(name = "current_days", defaultValue = "0") val currentDays: Int = 0,
    @ColumnInfo(name = "longest_days", defaultValue = "0") val longestDays: Int = 0,
    @ColumnInfo(name = "last_active_date") val lastActiveDate: Long? = null,
    @ColumnInfo(name = "freezes_remaining", defaultValue = "2") val freezesRemaining: Int = 2
)
