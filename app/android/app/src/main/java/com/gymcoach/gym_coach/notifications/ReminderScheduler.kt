package com.gymcoach.gym_coach.notifications

import android.content.Context
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import dagger.hilt.android.qualifiers.ApplicationContext
import java.time.Duration
import java.time.LocalTime
import java.time.ZonedDateTime
import java.util.concurrent.TimeUnit
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Schedules a 24-hour periodic work request for the daily reminder. Survives
 * reboot (WorkManager re-enqueues automatically), so we don't strictly need a
 * BootReceiver — but BootReceiver still re-arms the schedule if the user
 * cleared app data or wiped notifications.
 */
@Singleton
class ReminderScheduler @Inject constructor(
    @ApplicationContext private val context: Context
) {
    fun scheduleDaily(hour: Int = 19, minute: Int = 0) {
        val now = ZonedDateTime.now()
        var first = now.with(LocalTime.of(hour, minute))
        if (!first.isAfter(now)) first = first.plusDays(1)
        val delayMillis = Duration.between(now, first).toMillis()
        val request = PeriodicWorkRequestBuilder<DailyReminderWorker>(24, TimeUnit.HOURS)
            .setInitialDelay(delayMillis, TimeUnit.MILLISECONDS)
            .build()
        WorkManager.getInstance(context).enqueueUniquePeriodicWork(
            UNIQUE_NAME,
            ExistingPeriodicWorkPolicy.KEEP,
            request
        )
    }

    fun cancel() {
        WorkManager.getInstance(context).cancelUniqueWork(UNIQUE_NAME)
    }

    companion object {
        const val UNIQUE_NAME = "daily_reminder"
    }
}
