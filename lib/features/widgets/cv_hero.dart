import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter/models/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/cv_provider.dart';
import '../../../theme/app_theme.dart';
import '../../../shared/app_button.dart';

class CvHero extends ConsumerStatefulWidget {
  final VoidCallback onContactTap;

  const CvHero({super.key, required this.onContactTap});

  @override
  ConsumerState<CvHero> createState() => _CvHeroState();
}

class _CvHeroState extends ConsumerState<CvHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      constraints: const BoxConstraints(minHeight: 520),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Stack(
        children: [
          // Blobs décoratifs
          Positioned(
            top: -100,
            right: -100,
            child: _Blob(size: 500, color: AppColors.c3.withValues(alpha: 0.6)),
          ),
          Positioned(
            bottom: -80,
            left: MediaQuery.of(context).size.width * 0.2,
            child: _Blob(size: 350, color: AppColors.c4.withValues(alpha: 0.8)),
          ),

          // Contenu
          Padding(
            padding: EdgeInsets.fromLTRB(
              hPad,
              AppSpacing.xxl,
              hPad,
              AppSpacing.xl,
            ),
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 3, child: _HeroLeft(profile: profile)),
                          const SizedBox(width: AppSpacing.xl),
                          Expanded(
                            flex: 2,
                            child: _HeroRight(
                              profile: profile,
                              onContactTap: widget.onContactTap,
                              onLaunchUrl: _launchUrl,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroLeft(profile: profile),
                          const SizedBox(height: AppSpacing.lg),
                          _HeroRight(
                            profile: profile,
                            onContactTap: widget.onContactTap,
                            onLaunchUrl: _launchUrl,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Blob ──
class _Blob extends StatelessWidget {
  final double size;
  final Color color;

  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

// ── Partie gauche : nom + titre + résumé ──
class _HeroLeft extends StatelessWidget {
  final Profile profile;

  const _HeroLeft({required this.profile});

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width > 768 ? 80.0 : 52.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 32, height: 1, color: AppColors.accent),
            const SizedBox(width: 10),
            Text('Développeur Full Stack Mobile', style: AppTextStyles.label),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Nom
        Text(
          profile.name.split(' ')[0],
          style: AppTextStyles.displayLarge.copyWith(fontSize: fontSize),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.c2, AppColors.c3],
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            profile.name.split(' ')[1],
            style: AppTextStyles.displayLarge.copyWith(
              fontSize: fontSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = AppColors.c2,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Résumé
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(profile.summary, style: AppTextStyles.bodyLarge),
        ),
      ],
    );
  }
}

// ── Partie droite : stats + actions ──
class _HeroRight extends StatelessWidget {
  final Profile profile;
  final VoidCallback onContactTap;
  final Future<void> Function(String url) onLaunchUrl;

  const _HeroRight({
    required this.profile,
    required this.onContactTap,
    required this.onLaunchUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats cards
        Row(
          children: [
            Expanded(
              child: _StatCard(
                number: '6+',
                label: 'Ans d\'expérience',
                accent: true,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _StatCard(number: '5', label: 'Pays couverts'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _StatCard(number: '3', label: 'Langues parlées'),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _StatCard(number: 'Lille', label: 'Localisation'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Actions
        AppButton(
          label: 'Me contacter',
          onTap: onContactTap,
          style: AppButtonStyle.dark,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'LinkedIn →',
          onTap: () => onLaunchUrl(profile.linkedin),
          style: AppButtonStyle.outline,
        ),
      ],
    );
  }
}

// ── Stat card ──
class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  final bool accent;

  const _StatCard({
    required this.number,
    required this.label,
    this.accent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: accent ? AppColors.accent : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent ? AppColors.accent : AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: AppTextStyles.displaySmall.copyWith(
              fontSize: 32,
              color: accent ? Colors.white : AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: accent
                  ? Colors.white.withValues(alpha: 0.75)
                  : AppColors.inkMid,
            ),
          ),
        ],
      ),
    );
  }
}
