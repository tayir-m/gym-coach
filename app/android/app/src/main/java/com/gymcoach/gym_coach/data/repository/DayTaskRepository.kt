package com.gymcoach.gym_coach.data.repository

import com.gymcoach.gym_coach.data.db.dao.DayTaskDao
import com.gymcoach.gym_coach.data.db.entity.DayTaskEntity
import com.gymcoach.gym_coach.domain.model.DayTask
import com.gymcoach.gym_coach.domain.model.Meal
import com.gymcoach.gym_coach.domain.model.Workout
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.builtins.MapSerializer
import kotlinx.serialization.builtins.serializer
import kotlinx.serialization.json.Json
import java.time.LocalDate
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class DayTaskRepository @Inject constructor(
    private val dao: DayTaskDao
) {
    private val json = Json { ignoreUnknownKeys = true }

    suspend fun getByDate(planId: Int, date: LocalDate): DayTask? =
        dao.getByDate(planId.toLong(), date.toEpochDay())?.let(::toModel)

    suspend fun getAllForPlan(planId: Int): List<DayTask> =
        dao.getAllForPlan(planId.toLong()).map(::toModel)

    suspend fun markWorkoutDone(id: Int) =
        dao.markWorkoutDone(id.toLong(), System.currentTimeMillis())

    suspend fun markMealDone(id: Int, slot: String, done: Boolean) =
        dao.markMealDoneAtomic(id.toLong(), slot, done)

    suspend fun awardXp(id: Int, additionalXp: Int) {
        if (additionalXp <= 0) return
        dao.addXp(id.toLong(), additionalXp)
    }

    suspend fun totalXp(): Int = dao.totalXp()
    suspend fun totalWorkoutsCompleted(): Int = dao.totalWorkoutsCompleted()

    /**
     * Mirrors `lib/data/repositories/gamification_repository.dart`:
     * count rows where completed_workout = true AND completed_meals JSON
     * object has every value == true AND the map is non-empty.
     */
    suspend fun totalDaysAllMealsCompleted(): Int {
        // The Drift code filtered in-memory; we do the same by fetching the
        // completed-meals JSON for completed-workout rows and parsing in
        // Kotlin.
        return dao.completedWorkoutRows().count { row ->
            val map = parseCompletedMeals(row.completedMeals)
            map.isNotEmpty() && map.values.all { it }
        }
    }

    private fun toModel(row: DayTaskEntity): DayTask {
        val workout = if (row.workoutJson.isEmpty()) null
        else json.decodeFromString(Workout.serializer(), row.workoutJson)
        val meals = if (row.mealsJson.isEmpty()) emptyList()
        else json.decodeFromString(ListSerializer(Meal.serializer()), row.mealsJson)
        val completed = parseCompletedMeals(row.completedMeals)
        return DayTask(
            dbId = row.id.toInt(),
            planId = row.planId.toInt(),
            dayIndex = row.dayIndex,
            date = LocalDate.ofEpochDay(row.date),
            workout = workout,
            meals = meals,
            completedWorkout = row.completedWorkout,
            completedMeals = completed,
            xpAwarded = row.xpAwarded,
            completedAt = row.completedAt
        )
    }

    private fun parseCompletedMeals(raw: String): Map<String, Boolean> {
        if (raw.isEmpty() || raw == "{}") return emptyMap()
        return runCatching {
            json.decodeFromString(MapSerializer(String.serializer(), Boolean.serializer()), raw)
        }.getOrElse { emptyMap() }
    }
}
