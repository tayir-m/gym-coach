package com.gymcoach.gym_coach.update

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.gymcoach.gym_coach.R
import java.io.DataInputStream
import java.io.File
import java.io.IOException
import java.net.InetAddress
import java.net.ServerSocket
import java.net.Socket
import kotlin.concurrent.thread

/**
 * Foreground service that listens on a loopback TCP socket for the daemon to
 * push a fresh debug APK into.
 *
 * Why TCP over FileObserver / Unix-socket / ContentProvider:
 *   - The PRoot userspace (where the daemon runs) cannot write into the
 *     app's own external files dir (`/sdcard/Android/data/<pkg>/`) due to
 *     scoped-storage SELinux, and `run-as` / real `su` aren't available.
 *   - Daemon → `127.0.0.1:<port>` shares the kernel network stack with the
 *     Android app process, so bytes flow without permission drama.
 *
 * Protocol:
 *   - 4-byte big-endian length prefix
 *   - exactly that many bytes of APK payload
 *
 * On a complete upload we hand the file off to [AppUpdateManager] which runs
 * a [android.content.pm.PackageInstaller.Session] install and relaunches
 * MainActivity via the PendingIntent result.
 */
class UpdateObserverService : Service() {

    @Volatile private var serverSocket: ServerSocket? = null
    @Volatile private var serverThread: Thread? = null
    @Volatile private var stopped = false

    override fun onCreate() {
        super.onCreate()
        ensureChannel()
        startForeground(NOTIFICATION_ID, buildNotification())
        startServer()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int = START_STICKY

    override fun onDestroy() {
        stopped = true
        try { serverSocket?.close() } catch (_: IOException) {}
        serverThread?.interrupt()
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun startServer() {
        serverThread = thread(name = "reload-server", isDaemon = true) {
            try {
                // Bind explicitly to loopback; the daemon runs on the same
                // kernel network stack.
                val server = ServerSocket(PORT, /* backlog */ 4, InetAddress.getByName("127.0.0.1"))
                serverSocket = server
                Log.i(TAG, "listening on 127.0.0.1:$PORT")
                while (!stopped) {
                    val client = try {
                        server.accept()
                    } catch (_: IOException) {
                        if (stopped) return@thread
                        continue
                    }
                    // One client at a time — sequential is fine for hot reload.
                    handleClient(client)
                }
            } catch (t: Throwable) {
                Log.e(TAG, "server failed", t)
            }
        }
    }

    private fun handleClient(client: Socket) {
        client.use { sock ->
            DataInputStream(sock.getInputStream()).use { input ->
                val length = input.readInt()
                if (length <= 0 || length > MAX_APK_BYTES) {
                    Log.w(TAG, "rejecting upload: length=$length")
                    sock.getOutputStream().write(byteArrayOf(0x01))
                    return
                }
                val updateFile = File(filesDir, UPDATE_FILE_NAME)
                try {
                    updateFile.outputStream().use { out ->
                        val buf = ByteArray(BUF_SIZE)
                        var remaining = length
                        while (remaining > 0) {
                            val n = input.read(buf, 0, minOf(buf.size, remaining))
                            if (n <= 0) {
                                Log.w(TAG, "short read ($remaining bytes left)")
                                sock.getOutputStream().write(byteArrayOf(0x01))
                                return
                            }
                            out.write(buf, 0, n)
                            remaining -= n
                        }
                    }
                    Log.i(TAG, "received ${length}B -> ${updateFile.absolutePath}")
                    AppUpdateManager(applicationContext).installFrom(updateFile)
                    sock.getOutputStream().write(byteArrayOf(0x00))
                } catch (t: Throwable) {
                    Log.e(TAG, "upload handler failed", t)
                    sock.getOutputStream().write(byteArrayOf(0x01))
                }
            }
        }
    }

    private fun ensureChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val mgr = getSystemService(NotificationManager::class.java) ?: return
        if (mgr.getNotificationChannel(CHANNEL_ID) != null) return
        mgr.createNotificationChannel(
            NotificationChannel(
                CHANNEL_ID,
                getString(R.string.notif_hot_reload_channel),
                NotificationManager.IMPORTANCE_LOW
            )
        )
    }

    private fun buildNotification(): Notification =
        NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(getString(R.string.notif_hot_reload_title))
            .setContentText(getString(R.string.notif_hot_reload_text))
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()

    companion object {
        private const val TAG = "UpdateObserver"
        private const val CHANNEL_ID = "hot_reload"
        private const val NOTIFICATION_ID = 9001
        const val PORT = 9876
        private const val UPDATE_FILE_NAME = "gym-coach-update.apk"
        private const val BUF_SIZE = 64 * 1024
        // 100 MiB sanity cap — debug APKs are ~20 MiB today.
        private const val MAX_APK_BYTES = 100L * 1024 * 1024

        fun start(context: Context) {
            val intent = Intent(context, UpdateObserverService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }
    }
}