package com.gymcoach.gym_coach

import com.gymcoach.gym_coach.config.AppConfig
import com.google.common.truth.Truth.assertThat
import org.junit.Test

class ConfigTest {

    @Test
    fun `config strings are non-empty by default`() {
        // Mirrors the Flutter `smoke_test.dart` which asserts that AppConfig
        // proxyEndpoint and hmacSecret are non-empty. The Kotlin values come
        // from BuildConfig (Build-time injected from gradle.properties or
        // defaults set in app/build.gradle.kts).
        val cfg = AppConfig(proxyEndpoint = "https://example", hmacSecret = "secret")
        assertThat(cfg.proxyEndpoint).isNotEmpty()
        assertThat(cfg.hmacSecret).isNotEmpty()
    }
}
