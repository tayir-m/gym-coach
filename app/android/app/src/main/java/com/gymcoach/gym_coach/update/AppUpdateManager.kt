package com.gymcoach.gym_coach.update

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInstaller
import android.os.Build
import android.util.Log
import com.gymcoach.gym_coach.MainActivity
import java.io.File

/**
 * Self-install helper. The companion [UpdateObserverService] hands us a fresh
 * APK file (delivered by the hot-reload daemon over loopback TCP), and we
 * drive a [PackageInstaller.Session] install of it.
 *
 * Self-install works because the daemon writes APKs signed with the same
 * debug keystore already on the device.
 */
class AppUpdateManager(private val context: Context) {

    /**
     * Install the supplied APK. The caller is responsible for sanity-checking
     * the file (length, etc.) — we just verify the basics again.
     */
    fun installFrom(apk: File) {
        if (!apk.exists() || apk.length() < MIN_APK_BYTES) {
            Log.w(TAG, "refusing install: bad file ${apk.absolutePath} (${apk.length()}B)")
            return
        }
        val installedTime = try {
            context.packageManager.getPackageInfo(context.packageName, 0).lastUpdateTime
        } catch (_: Exception) {
            return
        }
        if (apk.lastModified() <= installedTime) {
            Log.i(TAG, "skipping install: APK not newer than installed package")
            return
        }

        try {
            commitSession(apk)
        } catch (t: Throwable) {
            Log.w(TAG, "self-install failed", t)
        }
    }

    private fun commitSession(apk: File) {
        val installer = context.packageManager.packageInstaller
        val params = PackageInstaller.SessionParams(PackageInstaller.SessionParams.MODE_FULL_INSTALL)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // No "install this update?" sheet — it's our own debug-signed
            // update and the developer is the only human at the wheel.
            params.setRequireUserAction(PackageInstaller.SessionParams.USER_ACTION_NOT_REQUIRED)
        }

        val sessionId = installer.createSession(params)
        val session = installer.openSession(sessionId)
        try {
            session.openWrite("gym-coach-hot-reload", 0, -1).use { out ->
                apk.inputStream().use { input -> input.copyTo(out) }
            }
            val intent = Intent(context, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK)
                putExtra(EXTRA_RELOADED_AT, System.currentTimeMillis())
            }
            val pi = PendingIntent.getActivity(
                context,
                sessionId,
                intent,
                PendingIntent.FLAG_MUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            )
            session.commit(pi.intentSender)
            Log.i(TAG, "session $sessionId committed")
        } finally {
            session.close()
        }
    }

    companion object {
        private const val TAG = "AppUpdateManager"
        const val EXTRA_RELOADED_AT = "reloaded_at"
        private const val MIN_APK_BYTES = 1024L
    }
}