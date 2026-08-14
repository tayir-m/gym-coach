import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

enum AppButtonKind { primary, secondary, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonKind kind;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.kind = AppButtonKind.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = switch (kind) {
      AppButtonKind.primary => AppColors.duoGreen,
      AppButtonKind.secondary => Colors.white,
      AppButtonKind.danger => AppColors.duoRed,
    };
    final fg = switch (kind) {
      AppButtonKind.secondary => AppColors.duoText,
      _ => Colors.white,
    };
    final borderColor = AppColors.duoBlack;

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: AppColors.duoBlack, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: fg),
                const SizedBox(width: 8),
              ],
              Text(label, style: AppTextStyles.button.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
