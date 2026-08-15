package com.gymcoach.gym_coach.data.db.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Transaction
import com.gymcoach.gym_coach.data.db.entity.DayTaskEntity
import org.json.JSONObject

@Dao
interface DayTaskDao {
    @Insert
    suspend fun insertAll(tasks: List<DayTaskEntity>): List<Long>

    @Query("SELECT * FROM day_tasks WHERE plan_id = :planId AND date = :dateEpochDay LIMIT 1")
    suspend fun getByDate(planId: Long, dateEpochDay: Long): DayTaskEntity?

    @Query("SELECT * FROM day_tasks WHERE plan_id = :planId ORDER BY day_index ASC")
    suspend fun getAllForPlan(planId: Long): List<DayTaskEntity>

    @Query("SELECT * FROM day_tasks WHERE id = :id")
    suspend fun getById(id: Long): DayTaskEntity?

    @Query("UPDATE day_tasks SET completed_workout = 1, completed_at = :nowEpochMs WHERE id = :id")
    suspend fun markWorkoutDone(id: Long, nowEpochMs: Long)

    @Query("UPDATE day_tasks SET xp_awarded = xp_awarded + :additionalXp WHERE id = :id")
    suspend fun addXp(id: Long, additionalXp: Int)

    @Query("SELECT COALESCE(SUM(xp_awarded), 0) FROM day_tasks")
    suspend fun totalXp(): Int

    @Query("SELECT COUNT(*) FROM day_tasks WHERE completed_workout = 1")
    suspend fun totalWorkoutsCompleted(): Int

    @Query("SELECT * FROM day_tasks WHERE completed_workout = 1")
    suspend fun completedWorkoutRows(): List<DayTaskEntity>

    /**
     * The original Dart code declares `completed_meals` as a JSON object whose
     * values are bools. We simulate the read-modify-write transactionally so
     * the in-memory merge is atomic on the row.
     */
    @Transaction
    suspend fun markMealDoneAtomic(id: Long, slot: String, done: Boolean) {
        val row = getById(id) ?: return
        val obj = if (row.completedMeals.isEmpty() || row.completedMeals == "{}") JSONObject() else JSONObject(row.completedMeals)
        obj.put(slot, done)
        writeCompletedMeals(id, obj.toString())
    }

    @Query("UPDATE day_tasks SET completed_meals = :json WHERE id = :id")
    suspend fun writeCompletedMeals(id: Long, json: String)

    @Query("SELECT completed_meals FROM day_tasks WHERE id = :id")
    suspend fun readCompletedMeals(id: Long): String?
}
