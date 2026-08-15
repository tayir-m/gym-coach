package com.gymcoach.gym_coach.data.db.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import com.gymcoach.gym_coach.data.db.entity.PlanEntity

@Dao
interface PlanDao {
    @Insert
    suspend fun insert(plan: PlanEntity): Long

    @Query("SELECT * FROM plans ORDER BY version DESC, id DESC LIMIT 1")
    suspend fun latest(): PlanEntity?

    @Query("SELECT * FROM plans WHERE active = 1 ORDER BY version DESC, id DESC LIMIT 1")
    suspend fun active(): PlanEntity?

    @Query("UPDATE plans SET active = 0")
    suspend fun deactivateAll()

    @Update
    suspend fun update(plan: PlanEntity)
}
