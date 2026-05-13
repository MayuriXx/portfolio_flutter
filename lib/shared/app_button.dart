import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum AppButtonStyle { dark, outline }

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final AppButtonStyle style;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.style = AppButtonStyle.dark,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.style == AppButtonStyle.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: _hovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
          decoration: BoxDecoration(
            color: isDark
                ? (_hovered ? const Color(0xFF2e3d38) : AppColors.ink)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(100),
            border: isDark
                ? null
                : Border.all(
                    color: _hovered ? AppColors.accentMid : AppColors.border,
                    width: 1.5,
                  ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark
                  ? Colors.white
                  : (_hovered ? AppColors.ink : AppColors.inkMid),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
