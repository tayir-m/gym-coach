package com.gymcoach.gym_coach.gamification

import com.google.common.truth.Truth.assertThat
import org.junit.Test

class BadgeEngineTest {

    @Test
    fun `new user gets no badges`() {
        assertThat(BadgeEngine.checkUnlockedBadges(emptyMap())).isEmpty()
    }

    @Test
    fun `first workout badge unlocks at 1`() {
        val stats = mapOf(
            "totalWorkoutsCompleted" to 1,
            "longestStreak" to 0,
            "totalDaysAllMealsCompleted" to 0,
            "level" to 1
        )
        assertThat(BadgeEngine.checkUnlockedBadges(stats)).containsExactly(BadgeEngine.FIRST_WORKOUT)
    }

    @Test
    fun `one week streak badge unlocks at 7`() {
        val stats = mapOf(
            "totalWorkoutsCompleted" to 0,
            "longestStreak" to 7,
            "totalDaysAllMealsCompleted" to 0,
            "level" to 1
        )
        assertThat(BadgeEngine.checkUnlockedBadges(stats)).contains(BadgeEngine.ONE_WEEK_STREAK)
    }

    @Test
    fun `hundred days badge unlocks at 100`() {
        val stats = mapOf(
            "totalWorkoutsCompleted" to 0,
            "longestStreak" to 100,
            "totalDaysAllMealsCompleted" to 0,
            "level" to 1
        )
        assertThat(BadgeEngine.checkUnlockedBadges(stats)).contains(BadgeEngine.HUNDRED_DAYS)
    }

    @Test
    fun `iron stomach badge unlocks after 7 all-meal days`() {
        val stats = mapOf(
            "totalWorkoutsCompleted" to 0,
            "longestStreak" to 0,
            "totalDaysAllMealsCompleted" to 7,
            "level" to 1
        )
        assertThat(BadgeEngine.checkUnlockedBadges(stats)).contains(BadgeEngine.IRON_STOMACH)
    }

    @Test
    fun `fitness owl badge unlocks at level 10`() {
        val stats = mapOf(
            "totalWorkoutsCompleted" to 0,
            "longestStreak" to 0,
            "totalDaysAllMealsCompleted" to 0,
            "level" to 10
        )
        assertThat(BadgeEngine.checkUnlockedBadges(stats)).contains(BadgeEngine.FITNESS_OWL)
    }
}
