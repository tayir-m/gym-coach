package com.gymcoach.gym_coach.data.db.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "day_tasks",
    foreignKeys = [
        ForeignKey(
            entity = PlanEntity::class,
            parentColumns = ["id"],
            childColumns = ["plan_id"],
            onDelete = ForeignKey.CASCADE
        )
    ],
    indices = [Index("plan_id"), Index(value = ["plan_id", "date"], unique = false)]
)
data class DayTaskEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0L,
    @ColumnInfo(name = "plan_id") val planId: Long,
    @ColumnInfo(name = "day_index") val dayIndex: Int,
    val date: Long,
    @ColumnInfo(name = "workout_json") val workoutJson: String,
    @ColumnInfo(name = "meals_json") val mealsJson: String,
    @ColumnInfo(name = "completed_workout") val completedWorkout: Boolean = false,
    @ColumnInfo(name = "completed_meals", defaultValue = "'{}'") val completedMeals: String = "{}",
    @ColumnInfo(name = "xp_awarded", defaultValue = "0") val xpAwarded: Int = 0,
    @ColumnInfo(name = "completed_at") val completedAt: Long? = null
)
