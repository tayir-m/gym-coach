package com.gymcoach.gym_coach.notifications

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.getSystemService
import com.gymcoach.gym_coach.R
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Creates the daily-reminder notification channel and exposes a small helper to
 * post a reminder. Channel id, name, description and importance mirror the
 * Flutter app's flutter_local_notifications configuration 1:1.
 */
@Singleton
class NotificationFactory @Inject constructor(
    @ApplicationContext private val context: Context
) {

    fun createChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val manager: NotificationManager = context.getSystemService() ?: return
        val channel = NotificationChannel(
            CHANNEL_DAILY,
            context.getString(R.string.notif_channel_daily_name),
            NotificationManager.IMPORTANCE_HIGH
        ).apply {
            description = context.getString(R.string.notif_channel_daily_desc)
        }
        manager.createNotificationChannel(channel)
    }

    fun show(id: Int, title: String, body: String) {
        // Android 13+: POST_NOTIFICATIONS is a runtime permission. The user
        // may revoke it (or never grant it). Skip silently when missing so
        // scheduling/retry loops don't crash the worker.
        val manager = NotificationManagerCompat.from(context)
        if (!manager.areNotificationsEnabled()) return
        val notification = NotificationCompat.Builder(context, CHANNEL_DAILY)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .build()
        try {
            manager.notify(id, notification)
        } catch (_: SecurityException) {
            // Defensive: race between the enabled-check and a revocation.
        }
    }

    companion object {
        const val CHANNEL_DAILY = "daily_reminder"
    }
}
