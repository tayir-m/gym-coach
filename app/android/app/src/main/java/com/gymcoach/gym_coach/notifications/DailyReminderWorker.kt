package com.gymcoach.gym_coach.notifications

import android.content.Context
import androidx.hilt.work.HiltWorker
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.gymcoach.gym_coach.R
import dagger.assisted.Assisted
import dagger.assisted.AssistedInject

/**
 * Posts the daily 19:00 reminder. Scheduled via ReminderScheduler as a 24h
 * periodic work request with initialDelay = next 19:00.
 */
@HiltWorker
class DailyReminderWorker @AssistedInject constructor(
    @Assisted context: Context,
    @Assisted params: WorkerParameters,
    private val notifier: NotificationFactory
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        notifier.show(
            id = 0,
            title = applicationContext.getString(R.string.notif_daily_title),
            body  = applicationContext.getString(R.string.notif_daily_body)
        )
        return Result.success()
    }
}
