package com.gymcoach.gym_coach.config

/** Runtime config, populated from BuildConfig fields injected by `app/build.gradle.kts`. */
data class AppConfig(
    val proxyEndpoint: String,
    val hmacSecret: String
) {
    val isConfigured: Boolean
        get() = proxyEndpoint.isNotEmpty() && hmacSecret.isNotEmpty()
}
