import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../theme/app_theme.dart';

class ContactStrip extends StatelessWidget {
  const ContactStrip({super.key});

  Future<void> _launchEmail() async {
    final uri = Uri(scheme: 'mailto', path: 'martho.evan@gmail.com');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchLinkedIn() async {
    final uri = Uri.parse('https://www.linkedin.com/in/evanmartho/');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpacing.xl),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ContactLeft(),
                const SizedBox(width: AppSpacing.lg),
                _ContactActions(
                  onEmail: _launchEmail,
                  onLinkedIn: _launchLinkedIn,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactLeft(),
                const SizedBox(height: AppSpacing.lg),
                _ContactActions(
                  onEmail: _launchEmail,
                  onLinkedIn: _launchLinkedIn,
                ),
              ],
            ),
    );
  }
}

// ── Partie gauche ──
class _ContactLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('On discute ?', style: AppTextStyles.displaySmall),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Disponible pour de nouvelles opportunités · Lille & remote',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

// ── Actions ──
class _ContactActions extends StatelessWidget {
  final VoidCallback onEmail;
  final VoidCallback onLinkedIn;

  const _ContactActions({required this.onEmail, required this.onLinkedIn});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _ContactButton(
          label: 'martho.evan@gmail.com',
          onTap: onEmail,
          style: _ContactButtonStyle.dark,
        ),
        _ContactButton(
          label: 'LinkedIn →',
          onTap: onLinkedIn,
          style: _ContactButtonStyle.outline,
        ),
      ],
    );
  }
}

// ── Bouton ──
enum _ContactButtonStyle { dark, outline }

class _ContactButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final _ContactButtonStyle style;

  const _ContactButton({
    required this.label,
    required this.onTap,
    required this.style,
  });

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.style == _ContactButtonStyle.dark;

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
