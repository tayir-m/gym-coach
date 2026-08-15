package com.gymcoach.gym_coach.domain

import com.gymcoach.gym_coach.domain.streak.StreakCalculator
import com.google.common.truth.Truth.assertThat
import java.time.LocalDate
import org.junit.Test

class StreakCalculatorTest {

    private val today = LocalDate.of(2026, 8, 15)
    private val yesterday = today.minusDays(1)
    private val twoDaysAgo = today.minusDays(2)

    @Test
    fun `first active day sets current to 1 and freezes to 0`() {
        val r = StreakCalculator.evaluateStreakOnActive(
            currentStreakDays = 0,
            longestStreakDays = 0,
            freezesRemaining = 2,
            lastActiveDate = null,
            now = today
        )
        assertThat(r.newCurrentDays).isEqualTo(1)
        assertThat(r.newLongestDays).isEqualTo(1)
        assertThat(r.freezesConsumed).isEqualTo(0)
        assertThat(r.streakBroken).isFalse()
    }

    @Test
    fun `consecutive day increments and never breaks`() {
        val r = StreakCalculator.evaluateStreakOnActive(
            currentStreakDays = 3,
            longestStreakDays = 5,
            freezesRemaining = 2,
            lastActiveDate = yesterday,
            now = today
        )
        assertThat(r.newCurrentDays).isEqualTo(4)
        assertThat(r.newLongestDays).isEqualTo(5)
        assertThat(r.freezesConsumed).isEqualTo(0)
        assertThat(r.streakBroken).isFalse()
    }

    @Test
    fun `skip one day consumes one freeze`() {
        val r = StreakCalculator.evaluateStreakOnActive(
            currentStreakDays = 3,
            longestStreakDays = 3,
            freezesRemaining = 2,
            lastActiveDate = twoDaysAgo,
            now = today
        )
        assertThat(r.newCurrentDays).isEqualTo(4)
        assertThat(r.freezesConsumed).isEqualTo(1)
        assertThat(r.streakBroken).isFalse()
    }

    @Test
    fun `skip two days with no freezes resets and marks broken`() {
        val r = StreakCalculator.evaluateStreakOnActive(
            currentStreakDays = 5,
            longestStreakDays = 7,
            freezesRemaining = 0,
            lastActiveDate = today.minusDays(3),
            now = today
        )
        assertThat(r.newCurrentDays).isEqualTo(1)
        assertThat(r.newLongestDays).isEqualTo(7)
        assertThat(r.freezesConsumed).isEqualTo(0)
        assertThat(r.streakBroken).isTrue()
    }

    @Test
    fun `same day is a no-op`() {
        val r = StreakCalculator.evaluateStreakOnActive(
            currentStreakDays = 5,
            longestStreakDays = 5,
            freezesRemaining = 2,
            lastActiveDate = today,
            now = today
        )
        assertThat(r.newCurrentDays).isEqualTo(5)
        assertThat(r.newLongestDays).isEqualTo(5)
        assertThat(r.freezesConsumed).isEqualTo(0)
    }

    @Test
    fun `shouldAwardFreeze only after 30 days`() {
        val awarded = today.minusDays(45)
        val recent = today.minusDays(10)
        assertThat(StreakCalculator.shouldAwardFreeze(awarded, today)).isTrue()
        assertThat(StreakCalculator.shouldAwardFreeze(recent, today)).isFalse()
        assertThat(StreakCalculator.shouldAwardFreeze(null, today)).isFalse()
    }
}
