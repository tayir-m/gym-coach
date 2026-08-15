package com.gymcoach.gym_coach.data.network

import com.google.common.truth.Truth.assertThat
import org.junit.Test

class HmacSigningInterceptorTest {

    @Test
    fun `hmac produces deterministic hex output`() {
        val hex = HmacSigningInterceptor.hmacSha256Hex("dev-secret-change-me", "1700000000.{\"a\":1}")
        // 64-char hex string
        assertThat(hex).hasLength(64)
        // Same inputs -> same outputs (determinism)
        val hex2 = HmacSigningInterceptor.hmacSha256Hex("dev-secret-change-me", "1700000000.{\"a\":1}")
        assertThat(hex).isEqualTo(hex2)
    }

    @Test
    fun `different bodies produce different signatures`() {
        val a = HmacSigningInterceptor.hmacSha256Hex("k", "ts.{}")
        val b = HmacSigningInterceptor.hmacSha256Hex("k", "ts.{\"a\":1}")
        assertThat(a).isNotEqualTo(b)
    }

    @Test
    fun `different secrets produce different signatures`() {
        val a = HmacSigningInterceptor.hmacSha256Hex("secret-a", "ts.body")
        val b = HmacSigningInterceptor.hmacSha256Hex("secret-b", "ts.body")
        assertThat(a).isNotEqualTo(b)
    }
}
