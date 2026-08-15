package com.gymcoach.gym_coach.data.db.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Unused by the app — mirrors the Flutter schema where the table existed but
 * no rows are ever inserted (the badge check is a pure function in
 * `BadgeEngine`).
 */
@Entity(tableName = "badges")
data class BadgeEntity(
    @PrimaryKey val code: String,
    val name: String,
    val description: String,
    val icon: String,
    @ColumnInfo(name = "condition_json") val conditionJson: String
)
