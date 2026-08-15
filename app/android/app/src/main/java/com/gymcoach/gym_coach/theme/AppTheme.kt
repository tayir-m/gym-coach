package com.gymcoach.gym_coach.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable

private val AppLightColors = lightColorScheme(
    primary = AppColors.duoGreen,
    onPrimary = androidx.compose.ui.graphics.Color.White,
    secondary = AppColors.duoPurple,
    onSecondary = androidx.compose.ui.graphics.Color.White,
    tertiary = AppColors.duoGold,
    error = AppColors.duoRed,
    background = AppColors.duoBackground,
    surface = androidx.compose.ui.graphics.Color.White,
    onSurface = AppColors.duoText,
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppLightColors,
        typography = AppTypography,
        content = content
    )
}
