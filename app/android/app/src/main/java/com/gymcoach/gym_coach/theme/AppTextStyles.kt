package com.gymcoach.gym_coach.theme

import androidx.compose.material3.Typography
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

/**
 * Mirrors `lib/theme/text_styles.dart`:
 *   h1   = 28sp/w800, duoText
 *   h2   = 22sp/w700, duoText
 *   body = 16sp/w500, duoText
 *   button = 16sp/w700, white, letterSpacing 0.8
 *
 * Mapped onto the Material 3 typography slots that actually exist in this
 * app, plus a couple of helpful extras.
 */
val AppTypography = Typography(
    displaySmall = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.ExtraBold, color = AppColors.duoText),
    headlineSmall = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.Bold, color = AppColors.duoText),
    titleLarge = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.Bold, color = AppColors.duoText),
    bodyLarge = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, color = AppColors.duoText),
    bodyMedium = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, color = AppColors.duoText),
    labelLarge = TextStyle(
        fontSize = 16.sp,
        fontWeight = FontWeight.Bold,
        color = Color.White,
        letterSpacing = 0.8.sp
    ),
)
