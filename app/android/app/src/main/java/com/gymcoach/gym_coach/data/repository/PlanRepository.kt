package com.gymcoach.gym_coach.data.repository

import androidx.room.withTransaction
import com.gymcoach.gym_coach.data.db.AppDatabase
import com.gymcoach.gym_coach.data.db.dao.DayTaskDao
import com.gymcoach.gym_coach.data.db.dao.PlanDao
import com.gymcoach.gym_coach.data.db.entity.DayTaskEntity
import com.gymcoach.gym_coach.data.db.entity.PlanEntity
import com.gymcoach.gym_coach.domain.model.Meal
import com.gymcoach.gym_coach.domain.model.Plan
import com.gymcoach.gym_coach.domain.model.StoredPlan
import com.gymcoach.gym_coach.domain.model.Workout
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.builtins.serializer
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.put
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Mirrors `lib/data/repositories/plan_repository.dart`. `create` writes a
 * `plans` row + N `day_tasks` rows in one transaction; `getActive` re-injects
 * the `start_date` column into the JSON before parsing.
 */
@Singleton
class PlanRepository @Inject constructor(
    private val planDao: PlanDao,
    private val dayTaskDao: DayTaskDao,
    private val database: AppDatabase
) {
    private val json = Json {
        ignoreUnknownKeys = true
        encodeDefaults = true
    }

    suspend fun create(plan: Plan): Int = database.withTransaction {
        val previous = planDao.latest()
        val nextVersion = (previous?.version ?: 0) + 1
        val startDate = plan.startDate?.let {
            LocalDateIso.parse(it)
        } ?: java.time.LocalDate.now()
        val planEntity = PlanEntity(
            version = nextVersion,
            startDate = startDate.toEpochDay(),
            weeks = plan.weeks,
            planJson = stripStartDate(plan),
            createdAt = System.currentTimeMillis(),
            active = true
        )
        val planId = planDao.insert(planEntity).toInt()

        val totalDays = plan.weeks * 7
        val tasks = (0 until totalDays).map { dayIndex ->
            val week = dayIndex / 7 + 1
            val dayOfWeek = dayIndex % 7 + 1
            val date = startDate.plusDays(dayIndex.toLong())
            val td = plan.trainingDays.firstOrNull { it.week == week && it.dayOfWeek == dayOfWeek }
            val dm = plan.dailyMeals.firstOrNull { it.week == week && it.dayOfWeek == dayOfWeek }
            val workoutJson = if (td != null) json.encodeToString(
                Workout.serializer(),
                Workout(td.title, td.estimatedMinutes, td.exercises)
            ) else ""
            val mealsJson = json.encodeToString(
                ListSerializer(Meal.serializer()),
                dm?.meals ?: emptyList()
            )
            DayTaskEntity(
                planId = planId.toLong(),
                dayIndex = dayIndex,
                date = date.toEpochDay(),
                workoutJson = workoutJson,
                mealsJson = mealsJson
            )
        }
        dayTaskDao.insertAll(tasks)
        planId
    }

    suspend fun deactivateAll() {
        planDao.deactivateAll()
    }

    suspend fun getActive(): StoredPlan? {
        val row = planDao.active() ?: return null
        val withStart = injectStartDate(row.planJson, row.startDate)
        val plan = json.decodeFromString(Plan.serializer(), withStart)
        return StoredPlan(id = row.id.toInt(), plan = plan)
    }

    private fun stripStartDate(plan: Plan): String {
        val obj = json.decodeFromString(JsonObject.serializer(), json.encodeToString(Plan.serializer(), plan))
        val filtered = JsonObject(obj.filterKeys { it != "start_date" })
        return json.encodeToString(JsonObject.serializer(), filtered)
    }

    private fun injectStartDate(planJson: String, epochDay: Long): String {
        val obj = json.decodeFromString(JsonObject.serializer(), planJson)
        val iso = java.time.LocalDate.ofEpochDay(epochDay).atStartOfDay(java.time.ZoneOffset.UTC).toInstant().toString()
        val withStart = JsonObject(obj.toMutableMap().apply { put("start_date", JsonPrimitive(iso)) })
        return json.encodeToString(JsonObject.serializer(), withStart)
    }
}

private object LocalDateIso {
    fun parse(iso: String): java.time.LocalDate {
        // Try ISO instant first, then date-only, then LocalDateTime.
        return runCatching {
            java.time.Instant.parse(iso).atZone(java.time.ZoneOffset.UTC).toLocalDate()
        }.getOrElse {
            runCatching { java.time.LocalDate.parse(iso) }.getOrElse {
                java.time.LocalDateTime.parse(iso).toLocalDate()
            }
        }
    }
}
