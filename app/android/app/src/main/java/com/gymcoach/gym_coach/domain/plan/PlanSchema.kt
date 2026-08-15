package com.gymcoach.gym_coach.domain.plan

import com.gymcoach.gym_coach.domain.model.Plan
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.Json

/**
 * Mirrors `lib/domain/plan_schema.dart`. `looksLikePlanJson` is a fast guard
 * used by the onboarding screen; `validatePlanJson` performs full validation.
 */
object PlanSchema {

    private val json = Json {
        ignoreUnknownKeys = true
        coerceInputValues = false
    }

    fun looksLikePlanJson(text: String): Boolean {
        val trimmed = text.trim()
        if (!trimmed.startsWith("{") || !trimmed.endsWith("}")) return false
        return runCatching { json.parseToJsonElement(trimmed) }.isSuccess
    }

    fun validatePlanJson(rawJson: String): PlanValidationResult {
        val trimmed = rawJson.trim()
        val parsed = runCatching { json.parseToJsonElement(trimmed) }.getOrNull()
            ?: return PlanValidationResult.Failure("not_json")
        val obj = parsed as? kotlinx.serialization.json.JsonObject
            ?: return PlanValidationResult.Failure("not_object")

        val required = listOf("weeks", "weekly_structure", "goal_summary", "training_days", "daily_meals")
        for (key in required) {
            if (!obj.containsKey(key)) return PlanValidationResult.Failure("missing_$key")
        }
        val weeks = (obj["weeks"] as? kotlinx.serialization.json.JsonPrimitive)?.content?.toIntOrNull()
            ?: return PlanValidationResult.Failure("bad_weeks")
        if (weeks <= 0) return PlanValidationResult.Failure("bad_weeks")
        if (obj["training_days"] !is kotlinx.serialization.json.JsonArray) return PlanValidationResult.Failure("bad_training_days")
        if (obj["daily_meals"]   !is kotlinx.serialization.json.JsonArray) return PlanValidationResult.Failure("bad_daily_meals")

        val withStart = if (obj.containsKey("start_date")) {
            trimmed
        } else {
            val now = java.time.Instant.now().toString()
            val mutable = obj.toMutableMap()
            mutable["start_date"] = kotlinx.serialization.json.JsonPrimitive(now)
            json.encodeToString(kotlinx.serialization.json.JsonObject.serializer(), kotlinx.serialization.json.JsonObject(mutable))
        }
        return try {
            val plan = json.decodeFromString(Plan.serializer(), withStart)
            PlanValidationResult.Success(plan)
        } catch (e: SerializationException) {
            PlanValidationResult.Failure("serialize:${e.message}")
        }
    }
}

sealed class PlanValidationResult {
    data class Success(val plan: Plan) : PlanValidationResult()
    data class Failure(val error: String) : PlanValidationResult()
}
