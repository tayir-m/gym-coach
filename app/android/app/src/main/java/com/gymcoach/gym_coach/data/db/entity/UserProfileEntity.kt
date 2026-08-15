package com.gymcoach.gym_coach.data.db.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "user_profiles")
data class UserProfileEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0L,
    val age: Int,
    @ColumnInfo(name = "height_cm") val heightCm: Double,
    @ColumnInfo(name = "weight_kg") val weightKg: Double,
    val sex: String,
    val goal: String,
    val experience: String,
    /** JSON array (string-list). */
    val equipment: String,
    val injuries: String?,
    @ColumnInfo(name = "dietary_notes") val dietaryNotes: String?,
    /** JSON object (slot→bool). */
    @ColumnInfo(name = "daily_schedule") val dailySchedule: String,
    @ColumnInfo(name = "updated_at") val updatedAt: Long
)
