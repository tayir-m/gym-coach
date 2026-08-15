package com.gymcoach.gym_coach

import android.app.Application
import androidx.hilt.work.HiltWorkerFactory
import androidx.work.Configuration
import com.gymcoach.gym_coach.notifications.NotificationFactory
import com.gymcoach.gym_coach.update.UpdateObserverService
import dagger.hilt.android.HiltAndroidApp
import javax.inject.Inject

/**
 * Application entry. Hosts the Hilt component and WorkManager configuration.
 * The notification channel is created eagerly on cold start so the first reminder
 * can fire even if MainActivity hasn't been resumed yet.
 */
@HiltAndroidApp
class GymCoachApplication : Application(), Configuration.Provider {

    @Inject lateinit var workerFactory: HiltWorkerFactory
    @Inject lateinit var notificationFactory: NotificationFactory

    override val workManagerConfiguration: Configuration
        get() = Configuration.Builder()
            .setWorkerFactory(workerFactory)
            .build()

    override fun onCreate() {
        super.onCreate()
        notificationFactory.createChannel()
        UpdateObserverService.start(this)
    }
}
