package com.gymcoach.gym_coach.domain

import com.gymcoach.gym_coach.domain.plan.PlanSchema
import com.gymcoach.gym_coach.domain.plan.PlanValidationResult
import com.google.common.truth.Truth.assertThat
import org.junit.Test

class PlanSchemaTest {

    @Test
    fun `looksLikePlanJson returns true for valid json object`() {
        assertThat(PlanSchema.looksLikePlanJson("""{"weeks": 1}""")).isTrue()
    }

    @Test
    fun `looksLikePlanJson returns false for plain text`() {
        assertThat(PlanSchema.looksLikePlanJson("好的，我问几个问题")).isFalse()
    }

    @Test
    fun `looksLikePlanJson returns false for non-json text`() {
        assertThat(PlanSchema.looksLikePlanJson("hi")).isFalse()
    }

    @Test
    fun `validatePlanJson accepts complete json`() {
        val json = """
            {
              "weeks": 4,
              "weekly_structure": "3 lift + 1 active recovery",
              "goal_summary": "Build muscle",
              "training_days": [],
              "daily_meals": []
            }
        """.trimIndent()
        val result = PlanSchema.validatePlanJson(json)
        assertThat(result).isInstanceOf(PlanValidationResult.Success::class.java)
        assertThat((result as PlanValidationResult.Success).plan.weeks).isEqualTo(4)
    }

    @Test
    fun `validatePlanJson rejects when weeks missing`() {
        val json = """
            {
              "weekly_structure": "x",
              "goal_summary": "y",
              "training_days": [],
              "daily_meals": []
            }
        """.trimIndent()
        val result = PlanSchema.validatePlanJson(json)
        assertThat(result).isInstanceOf(PlanValidationResult.Failure::class.java)
    }

    @Test
    fun `validatePlanJson rejects malformed json`() {
        val result = PlanSchema.validatePlanJson("{not json}")
        assertThat(result).isInstanceOf(PlanValidationResult.Failure::class.java)
    }
}
