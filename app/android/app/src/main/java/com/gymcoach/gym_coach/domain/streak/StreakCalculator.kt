package com.gymcoach.gym_coach.domain.streak

import java.time.LocalDate
import java.time.temporal.ChronoUnit

/**
 * Mirrors `lib/domain/streak_calculator.dart`. All logic is pure; the
 * repository owns the persistence. Day boundaries use the device's local
 * timezone (no UTC math), matching Drift's behavior.
 */
object StreakCalculator {

    data class StreakUpdate(
        val newCurrentDays: Int,
        val newLongestDays: Int,
        val freezesConsumed: Int,
        val streakBroken: Boolean
    )

    fun evaluateStreakOnActive(
        currentStreakDays: Int,
        longestStreakDays: Int,
        freezesRemaining: Int,
        lastActiveDate: LocalDate?,
        now: LocalDate
    ): StreakUpdate {
        if (lastActiveDate == null) {
            val newLongest = maxOf(longestStreakDays, 1)
            return StreakUpdate(1, newLongest, 0, false)
        }
        val daysSince = daysBetween(lastActiveDate, now).toInt()
        return when {
            daysSince == 0 -> StreakUpdate(currentStreakDays, longestStreakDays, 0, false)
            daysSince == 1 -> {
                val newCurrent = currentStreakDays + 1
                StreakUpdate(newCurrent, maxOf(longestStreakDays, newCurrent), 0, false)
            }
            daysSince >= 2 -> {
                val needed = daysSince - 1
                if (freezesRemaining >= needed) {
                    val newCurrent = currentStreakDays + 1
                    StreakUpdate(newCurrent, maxOf(longestStreakDays, newCurrent), needed, false)
                } else {
                    val newCurrent = freezesRemaining + 1
                    StreakUpdate(newCurrent, longestStreakDays, freezesRemaining, true)
                }
            }
            daysSince < 0 -> {
                // Future-dated lastActive (clock skew): reset to 1, no break flag.
                StreakUpdate(1, maxOf(longestStreakDays, 1), 0, false)
            }
            else -> StreakUpdate(currentStreakDays, longestStreakDays, 0, false)
        }
    }

    /** Returns true iff ≥30 days have passed since `lastFreezeAwardDate`. */
    fun shouldAwardFreeze(lastFreezeAwardDate: LocalDate?, now: LocalDate): Boolean {
        if (lastFreezeAwardDate == null) return false
        return daysBetween(lastFreezeAwardDate, now) >= 30
    }

    private fun daysBetween(a: LocalDate, b: LocalDate): Long =
        ChronoUnit.DAYS.between(a, b)
}
