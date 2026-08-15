package com.gymcoach.gym_coach.data.network

import com.gymcoach.gym_coach.config.AppConfig
import okhttp3.Interceptor
import okhttp3.Request
import okhttp3.Response
import okio.Buffer
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import javax.inject.Inject

/**
 * Adds `X-Timestamp` and `X-Signature` headers matching the Flutter app's HMAC
 * scheme: hex(HMAC-SHA256("<ts>.<body>", secret)). 4xx is fatal (no retry).
 * Body is buffered, so the original request can still be replayed by OkHttp.
 */
class HmacSigningInterceptor @Inject constructor(
    private val config: AppConfig
) : Interceptor {

    override fun intercept(chain: Interceptor.Chain): Response {
        val original = chain.request()
        val ts = (System.currentTimeMillis() / 1000L).toString()
        val bodyText = bodyToString(original)
        val sig = hmacSha256Hex(config.hmacSecret, "$ts.$bodyText")
        val signed = original.newBuilder()
            .header("X-Timestamp", ts)
            .header("X-Signature", sig)
            .build()
        return chain.proceed(signed)
    }

    private fun bodyToString(req: Request): String {
        val body = req.body ?: return ""
        return Buffer().also { body.writeTo(it) }.readUtf8()
    }

    companion object {
        fun hmacSha256Hex(secret: String, message: String): String {
            val mac = Mac.getInstance("HmacSHA256")
            mac.init(SecretKeySpec(secret.toByteArray(Charsets.UTF_8), "HmacSHA256"))
            return mac.doFinal(message.toByteArray(Charsets.UTF_8))
                .joinToString("") { byte -> "%02x".format(byte) }
        }
    }
}
