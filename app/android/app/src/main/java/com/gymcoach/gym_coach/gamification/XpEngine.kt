package com.gymcoach.gym_coach.gamification

/**
 * Mirrors `lib/gamification/xp_engine.dart`. All functions are pure.
 *
 * Rules (fixed in the original Flutter app):
 *   workout completion:  80 if all meals done, else 30
 *   meal completion:     20 when this is the LAST remaining meal
 *   streak milestone:    7→100, 30→300, 100→1000, 365→5000, else 0
 *   badge unlock:        200
 *   coach adjustment:    10
 */
object XpEngine {

    fun computeXpForWorkoutCompletion(allMealsCompleted: Boolean): XpAward =
        if (allMealsCompleted) XpAward(80, "workout_complete_with_meals")
        else XpAward(30, "workout_complete")

    fun computeXpForMealCompletion(mealsCompletedBefore: Int, totalMeals: Int): XpAward =
        if (totalMeals > 0 && mealsCompletedBefore == totalMeals - 1)
            XpAward(20, "all_meals_complete")
        else XpAward(0, "")

    fun computeXpForStreakMilestone(streakDays: Int): XpAward = when (streakDays) {
        365 -> XpAward(5000, "streak_365")
        100 -> XpAward(1000, "streak_100")
        30  -> XpAward(300,  "streak_30")
        7   -> XpAward(100,  "streak_7")
        else -> XpAward(0,   "")
    }

    fun computeXpForBadgeUnlock(): XpAward = XpAward(200, "badge_unlock")
    fun computeXpForCoachAdjustment(): XpAward = XpAward(10, "coach_adjustment")

    fun levelFromXp(totalXp: Int): Int = (totalXp / 1000) + 1
    fun xpToNextLevel(totalXp: Int): Int = (levelFromXp(totalXp) * 1000) - totalXp
}
