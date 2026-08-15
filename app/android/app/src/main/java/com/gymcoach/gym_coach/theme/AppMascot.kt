package com.gymcoach.gym_coach.theme

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/** Mood controls which emoji glyph appears inside the gold circle. */
enum class MascotMood { Happy, Cheer, Sad }

/**
 * Current mascot is an emoji placeholder, identical to the Flutter app
 * (`lib/theme/mascot.dart`): a gold circle with a 2dp black border and the
 * owl emoji in the center. Designed to be swapped for a Lottie animation at
 * `assets/mascot.json` later — that file is not bundled.
 */
@Composable
fun AppMascot(
    mood: MascotMood = MascotMood.Happy,
    sizeDp: Int = 80,
    modifier: Modifier = Modifier
) {
    val glyph = when (mood) {
        MascotMood.Happy, MascotMood.Cheer -> "🦉"
        MascotMood.Sad -> "🦉💧"
    }
    Box(
        modifier = modifier
            .size(sizeDp.dp)
            .background(AppColors.duoGold, CircleShape)
            .border(2.dp, AppColors.duoBlack, CircleShape)
            .clip(CircleShape),
        contentAlignment = Alignment.Center
    ) {
        Text(text = glyph, fontSize = (sizeDp * 0.5).sp)
    }
}
