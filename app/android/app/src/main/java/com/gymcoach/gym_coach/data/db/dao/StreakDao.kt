package com.gymcoach.gym_coach.data.db.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import com.gymcoach.gym_coach.data.db.entity.StreakEntity

@Dao
interface StreakDao {

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insertDefaultIfMissing(row: StreakEntity): Long

    @Query("SELECT * FROM streaks ORDER BY id ASC LIMIT 1")
    suspend fun first(): StreakEntity?

    /**
     * Mirror the Flutter app's `getStreak` lazy-init behaviour: insert a
     * defaults row only when the table is empty.
     */
    @Transaction
    suspend fun getOrCreate(): StreakEntity {
        insertDefaultIfMissing(StreakEntity())
        return first() ?: StreakEntity() // unreachable
    }

    @Query("UPDATE streaks SET current_days = :current, longest_days = :longest, last_active_date = :last, freezes_remaining = :freezes")
    suspend fun overwrite(current: Int, longest: Int, last: Long?, freezes: Int)
}
