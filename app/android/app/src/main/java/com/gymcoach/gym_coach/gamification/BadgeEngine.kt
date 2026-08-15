package com.gymcoach.gym_coach.gamification

/**
 * Mirrors `lib/gamification/badge_engine.dart`. The function is a pure
 * predicate over a stats map; no DB lookup.
 *
 * Required stats:
 *   totalWorkoutsCompleted (Int)
 *   longestStreak         (Int)
 *   totalDaysAllMealsCompleted (Int)
 *   level                 (Int)
 */
object BadgeEngine {

    const val FIRST_WORKOUT  = "FIRST_WORKOUT"
    const val ONE_WEEK_STREAK = "ONE_WEEK_STREAK"
    const val HUNDRED_DAYS = "HUNDRED_DAYS"
    const val IRON_STOMACH = "IRON_STOMACH"
    const val FITNESS_OWL = "FITNESS_OWL"

    fun checkUnlockedBadges(stats: Map<String, Int>): List<String> {
        val totalWorkouts = stats.getOrDefault("totalWorkoutsCompleted", 0)
        val longestStreak = stats.getOrDefault("longestStreak", 0)
        val allMealsDays  = stats.getOrDefault("totalDaysAllMealsCompleted", 0)
        val level         = stats.getOrDefault("level", 0)
        val out = mutableListOf<String>()
        if (totalWorkouts >= 1) out += FIRST_WORKOUT
        if (longestStreak >= 7) out += ONE_WEEK_STREAK
        if (longestStreak >= 100) out += HUNDRED_DAYS
        if (allMealsDays >= 7) out += IRON_STOMACH
        if (level >= 10) out += FITNESS_OWL
        return out
    }
}
