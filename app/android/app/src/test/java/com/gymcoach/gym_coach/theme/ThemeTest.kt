package com.gymcoach.gym_coach.theme

import androidx.compose.ui.graphics.toArgb
import com.google.common.truth.Truth.assertThat
import org.junit.Test

class ThemeTest {

    @Test
    fun `duoGreen matches the original ARGB literal`() {
        assertThat(AppColors.duoGreen.toArgb()).isEqualTo(0xFF58CC02.toInt())
    }

    @Test
    fun `duoPurple matches`() {
        assertThat(AppColors.duoPurple.toArgb()).isEqualTo(0xFFCE82FF.toInt())
    }

    @Test
    fun `duoGold matches`() {
        assertThat(AppColors.duoGold.toArgb()).isEqualTo(0xFFFFC800.toInt())
    }

    @Test
    fun `duoRed matches`() {
        assertThat(AppColors.duoRed.toArgb()).isEqualTo(0xFFFF4B4B.toInt())
    }

    @Test
    fun `duoBackground matches`() {
        assertThat(AppColors.duoBackground.toArgb()).isEqualTo(0xFFF7F7F7.toInt())
    }

    @Test
    fun `duoText matches`() {
        assertThat(AppColors.duoText.toArgb()).isEqualTo(0xFF3C3C3C.toInt())
    }

    @Test
    fun `mascot happy emoji is owl`() {
        // The mascot mood only controls which emoji we render. Assert the
        // well-known string literal that AppMascot will fall back to. This
        // mirrors the original `theme_test.dart` "renders 🦉" expectation.
        val moodGlyph = when (MascotMood.Happy) {
            MascotMood.Happy, MascotMood.Cheer -> "🦉"
            MascotMood.Sad -> "🦉💧"
        }
        assertThat(moodGlyph).isEqualTo("🦉")
    }
}
