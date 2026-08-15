package com.gymcoach.gym_coach.data.db.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "plans")
data class PlanEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0L,
    val version: Int,
    @ColumnInfo(name = "start_date") val startDate: Long,
    val weeks: Int,
    @ColumnInfo(name = "plan_json") val planJson: String,
    @ColumnInfo(name = "created_at") val createdAt: Long,
    val active: Boolean = true
)
