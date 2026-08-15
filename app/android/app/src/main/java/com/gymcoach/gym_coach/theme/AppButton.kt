package com.gymcoach.gym_coach.theme

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp

/** Mirrors `lib/theme/buttons.dart` — three button variants. */
enum class AppButtonKind { Primary, Secondary, Danger }

@Composable
fun AppButton(
    label: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    kind: AppButtonKind = AppButtonKind.Primary,
    icon: ImageVector? = null,
    enabled: Boolean = true
) {
    val shape = RoundedCornerShape(16.dp)
    val background = when (kind) {
        AppButtonKind.Primary -> AppColors.duoGreen
        AppButtonKind.Secondary -> Color.White
        AppButtonKind.Danger -> AppColors.duoRed
    }
    val foreground = if (kind == AppButtonKind.Secondary) AppColors.duoText else Color.White
    val shadowModifier = if (enabled) {
        Modifier.shadow(
            elevation = 4.dp,
            shape = shape,
            ambientColor = AppColors.duoBlack,
            spotColor = AppColors.duoBlack
        )
    } else Modifier

    Box(
        modifier = modifier
            .then(shadowModifier)
            .height(48.dp)
            .background(background, shape)
            .border(2.dp, AppColors.duoBlack, shape)
            .clip(shape)
            .clickable(enabled = enabled, onClick = onClick)
            .padding(horizontal = 20.dp, vertical = 8.dp),
        contentAlignment = Alignment.Center
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            if (icon != null) {
                Icon(icon, contentDescription = null, tint = foreground)
                Spacer(Modifier.width(8.dp))
            }
            Text(
                text = label,
                style = MaterialTheme.typography.labelLarge.copy(color = foreground)
            )
        }
    }
}
