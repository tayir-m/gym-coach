package com.gymcoach.gym_coach.notifications

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

/**
 * Re-arms the daily reminder after a device reboot, in case the user cleared
 * app data or disabled previously scheduled work. WorkManager normally
 * survives reboot itself, but this is a belt-and-braces re-schedule.
 */
class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Intent.ACTION_BOOT_COMPLETED) return
        ReminderScheduler(context.applicationContext).scheduleDaily(19, 0)
    }
}
