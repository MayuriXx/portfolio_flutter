import 'package:flutter/material.dart';
import 'package:portfolio_flutter/shared/app_button.dart';
import '../../../theme/app_theme.dart';

class ContactStrip extends StatelessWidget {
  final VoidCallback onEmail;
  final VoidCallback onLinkedIn;

  const ContactStrip({
    super.key,
    required this.onEmail,
    required this.onLinkedIn,
  });

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
                _ContactActions(onEmail: onEmail, onLinkedIn: onLinkedIn),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactLeft(),
                const SizedBox(height: AppSpacing.lg),
                _ContactActions(onEmail: onEmail, onLinkedIn: onLinkedIn),
              ],
            ),
    );
  }
}

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
        AppButton(
          label: 'martho.evan@gmail.com',
          onTap: onEmail,
          style: AppButtonStyle.dark,
        ),
        AppButton(
          label: 'LinkedIn →',
          onTap: onLinkedIn,
          style: AppButtonStyle.outline,
        ),
      ],
    );
  }
}
