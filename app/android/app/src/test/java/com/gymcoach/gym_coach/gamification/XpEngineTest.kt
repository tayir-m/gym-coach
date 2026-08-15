package com.gymcoach.gym_coach.gamification

import com.google.common.truth.Truth.assertThat
import org.junit.Test

class XpEngineTest {

    @Test
    fun `workout xp with all meals done is 80`() {
        assertThat(XpEngine.computeXpForWorkoutCompletion(allMealsCompleted = true).xp).isEqualTo(80)
    }

    @Test
    fun `workout xp with missing meals is 30`() {
        assertThat(XpEngine.computeXpForWorkoutCompletion(allMealsCompleted = false).xp).isEqualTo(30)
    }

    @Test
    fun `meal xp is 20 only on last remaining meal`() {
        assertThat(XpEngine.computeXpForMealCompletion(mealsCompletedBefore = 2, totalMeals = 3).xp).isEqualTo(20)
        assertThat(XpEngine.computeXpForMealCompletion(mealsCompletedBefore = 1, totalMeals = 3).xp).isEqualTo(0)
        assertThat(XpEngine.computeXpForMealCompletion(mealsCompletedBefore = 0, totalMeals = 0).xp).isEqualTo(0)
    }

    @Test
    fun `streak milestones match original fixed values`() {
        assertThat(XpEngine.computeXpForStreakMilestone(7).xp).isEqualTo(100)
        assertThat(XpEngine.computeXpForStreakMilestone(30).xp).isEqualTo(300)
        assertThat(XpEngine.computeXpForStreakMilestone(100).xp).isEqualTo(1000)
        assertThat(XpEngine.computeXpForStreakMilestone(365).xp).isEqualTo(5000)
        assertThat(XpEngine.computeXpForStreakMilestone(8).xp).isEqualTo(0)
    }

    @Test
    fun `badge and coach awards`() {
        assertThat(XpEngine.computeXpForBadgeUnlock().xp).isEqualTo(200)
        assertThat(XpEngine.computeXpForCoachAdjustment().xp).isEqualTo(10)
    }

    @Test
    fun `level is xp_div_1000_plus_1`() {
        assertThat(XpEngine.levelFromXp(0)).isEqualTo(1)
        assertThat(XpEngine.levelFromXp(999)).isEqualTo(1)
        assertThat(XpEngine.levelFromXp(1000)).isEqualTo(2)
        assertThat(XpEngine.levelFromXp(2500)).isEqualTo(3)
    }

    @Test
    fun `xpToNextLevel matches`() {
        assertThat(XpEngine.xpToNextLevel(0)).isEqualTo(1000)
        assertThat(XpEngine.xpToNextLevel(1500)).isEqualTo(500)
    }
}
