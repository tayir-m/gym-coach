package com.gymcoach.gym_coach.domain

import com.gymcoach.gym_coach.domain.model.Plan
import com.google.common.truth.Truth.assertThat
import kotlinx.serialization.json.Json
import org.junit.Test

class PlanParseTest {

    private val json = Json {
        ignoreUnknownKeys = true
        coerceInputValues = false
    }

    @Test
    fun `parse end-to-end with training days and daily meals and start date`() {
        val raw = """
            {
              "weeks": 2,
              "weekly_structure": "x",
              "goal_summary": "y",
              "start_date": "2026-08-15T00:00:00Z",
              "training_days": [
                {
                  "week": 1,
                  "day_of_week": 1,
                  "title": "Upper",
                  "focus": "Push",
                  "estimated_minutes": 45,
                  "exercises": [
                    {"name": "Bench", "sets": 3, "reps": "8-12", "rest_seconds": 90}
                  ]
                }
              ],
              "daily_meals": [
                {
                  "week": 1,
                  "day_of_week": 1,
                  "total_kcal": 2000,
                  "protein_g": 150,
                  "carbs_g": 200,
                  "fat_g": 60,
                  "meals": [
                    {"slot": "breakfast", "name": "Oats", "kcal": 400, "protein_g": 25, "carbs_g": 60, "fat_g": 8, "ingredients": ["oats"]}
                  ]
                }
              ]
            }
        """.trimIndent()
        val plan = json.decodeFromString(Plan.serializer(), raw)
        assertThat(plan.weeks).isEqualTo(2)
        assertThat(plan.trainingDays).hasSize(1)
        assertThat(plan.trainingDays[0].exercises[0].name).isEqualTo("Bench")
        assertThat(plan.dailyMeals[0].meals[0].slot).isEqualTo("breakfast")
        assertThat(plan.startDate).isEqualTo("2026-08-15T00:00:00Z")
    }
}
