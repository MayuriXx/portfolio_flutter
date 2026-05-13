import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/cv_provider.dart';
import '../../../theme/app_theme.dart';
import '../../../shared/app_button.dart';

class CvContact extends ConsumerWidget {
  const CvContact({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      decoration: const BoxDecoration(color: AppColors.ink),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpacing.xl),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ContactLeft(profile: profile)),
                const SizedBox(width: AppSpacing.xl),
                Expanded(
                  child: _ContactRight(
                    profile: profile,
                    onEmail: () => _launchEmail(profile.email),
                    onPhone: () => _launchPhone(profile.phone),
                    onLinkedIn: () => _launchUrl(profile.linkedin),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactLeft(profile: profile),
                const SizedBox(height: AppSpacing.lg),
                _ContactRight(
                  profile: profile,
                  onEmail: () => _launchEmail(profile.email),
                  onPhone: () => _launchPhone(profile.phone),
                  onLinkedIn: () => _launchUrl(profile.linkedin),
                ),
              ],
            ),
    );
  }
}

// ── Partie gauche ──
class _ContactLeft extends StatelessWidget {
  final profile;

  const _ContactLeft({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Numéro section
        Text(
          '04 —',
          style: AppTextStyles.label.copyWith(
            color: AppColors.accentMid,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Titre
        Text(
          'On discute ?',
          style: AppTextStyles.displayMedium.copyWith(color: Colors.white),
        ),
        const SizedBox(height: AppSpacing.md),

        // Tagline
        Text(
          'Disponible pour de nouvelles opportunités.\nLille & remote.',
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Boutons
        AppButton(
          label: profile.email,
          onTap: () {},
          style: AppButtonStyle.dark,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'LinkedIn →',
          onTap: () {},
          style: AppButtonStyle.outline,
        ),
      ],
    );
  }
}

// ── Partie droite : liens de contact ──
class _ContactRight extends StatelessWidget {
  final profile;
  final VoidCallback onEmail;
  final VoidCallback onPhone;
  final VoidCallback onLinkedIn;

  const _ContactRight({
    required this.profile,
    required this.onEmail,
    required this.onPhone,
    required this.onLinkedIn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactLink(
          icon: Icons.email_outlined,
          label: profile.email,
          onTap: onEmail,
        ),
        const SizedBox(height: AppSpacing.sm),
        _ContactLink(
          icon: Icons.phone_outlined,
          label: profile.phone,
          onTap: onPhone,
        ),
        const SizedBox(height: AppSpacing.sm),
        _ContactLink(
          icon: Icons.link,
          label: 'linkedin.com/in/evanmartho',
          onTap: onLinkedIn,
        ),
        const SizedBox(height: AppSpacing.sm),
        _ContactLink(
          icon: Icons.location_on_outlined,
          label: profile.location,
          onTap: () {},
        ),
      ],
    );
  }
}

// ── Lien de contact ──
class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: _hovered
              ? Matrix4.translationValues(4, 0, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.1 : 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              // Icône
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(widget.icon, size: 16, color: Colors.white),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Label
              Text(
                widget.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
