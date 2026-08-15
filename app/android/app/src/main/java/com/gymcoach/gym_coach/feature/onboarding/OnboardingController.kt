package com.gymcoach.gym_coach.feature.onboarding

import com.gymcoach.gym_coach.data.network.LlmClient
import com.gymcoach.gym_coach.data.network.dto.MessageDto
import com.gymcoach.gym_coach.domain.model.Plan
import com.gymcoach.gym_coach.domain.plan.PlanSchema
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import javax.inject.Inject

/**
 * Mirrors `lib/features/onboarding/onboarding_controller.dart`. Streaming is
 * incremental: each chunk is appended to the assistant bubble and the
 * accumulated text is re-scanned for a JSON plan.
 */
class OnboardingController @Inject constructor(
    private val llmClient: LlmClient
) {

    private val systemPrompt = """
        你是「教练猫头鹰」——一位经验丰富的健身教练和营养师。请用中文与用户对话。
        一次只问 1–2 个关键问题，逐步收集：年龄、身高、体重、目标（增肌/减脂/维持/力量提升）、
        训练经验（新手/中级/高级）、可用器械、伤病史、作息时间、饮食限制。
        不要提供医疗建议。在收集到足够信息后，输出严格符合以下 schema 的 JSON 计划（不要包裹 markdown）：

        {"weeks":12,"weekly_structure":"...","goal_summary":"...",
         "training_days":[...],"daily_meals":[...], "start_date":"ISO-8601"}

        其中 training_days[i] 包含 week, day_of_week, title, focus, estimated_minutes, exercises[];
        daily_meals[i] 包含 week, day_of_week, total_kcal, protein_g, carbs_g, fat_g, meals[].
    """.trimIndent()

    fun sendMessage(
        userText: String,
        history: List<MessageDto>
    ): Flow<String> = flow {
        val messages = buildList {
            add(MessageDto("system", systemPrompt))
            addAll(history)
            add(MessageDto("user", userText))
        }
        llmClient.chat(messages = messages).collect { emit(it) }
    }

    /** Returns the parsed plan if [accumulated] contains one, else null. */
    fun tryExtractPlan(accumulated: String): Plan? {
        if (!PlanSchema.looksLikePlanJson(accumulated)) return null
        val result = PlanSchema.validatePlanJson(accumulated)
        return when (result) {
            is com.gymcoach.gym_coach.domain.plan.PlanValidationResult.Success -> result.plan
            else -> null
        }
    }
}
