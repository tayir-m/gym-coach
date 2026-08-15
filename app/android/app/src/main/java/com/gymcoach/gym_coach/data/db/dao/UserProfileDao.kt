package com.gymcoach.gym_coach.data.db.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.gymcoach.gym_coach.data.db.entity.UserProfileEntity

@Dao
interface UserProfileDao {
    @Query("SELECT * FROM user_profiles LIMIT 1")
    suspend fun first(): UserProfileEntity?

    @Insert
    suspend fun insert(profile: UserProfileEntity): Long
}
