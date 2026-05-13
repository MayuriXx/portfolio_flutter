import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cv_provider.dart';
import '../../../theme/app_theme.dart';
import 'version_card.dart';

class VersionsGrid extends ConsumerWidget {
  const VersionsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versions = ref.watch(versionsProvider);
    final isWide = MediaQuery.of(context).size.width > 900;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: _GridTitle()),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(child: _GridIntro()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GridTitle(),
                    const SizedBox(height: AppSpacing.md),
                    _GridIntro(),
                  ],
                ),

          const SizedBox(height: AppSpacing.lg),

          // Grille
          isWide
              ? _WideGrid(versions: versions)
              : _NarrowGrid(versions: versions),
        ],
      ),
    );
  }
}

// ── Titre ──
class _GridTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Les quatre\nversions', style: AppTextStyles.displayMedium);
  }
}

// ── Intro ──
class _GridIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyMedium,
        children: [
          const TextSpan(
            text:
                'Chaque implémentation respecte le même design token et lit le même ',
          ),
          TextSpan(
            text: 'cv.json',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.accent,
              backgroundColor: AppColors.accentPale,
              fontFamily: 'monospace',
            ),
          ),
          const TextSpan(
            text:
                ' — seule l\'architecture interne change. Chaque repo est ouvert et documenté.',
          ),
        ],
      ),
    );
  }
}

// ── Grille large (2 colonnes) ──
class _WideGrid extends StatelessWidget {
  final List versions;

  const _WideGrid({required this.versions});

  @override
  Widget build(BuildContext context) {
    // On découpe en paires
    final rows = <Widget>[];
    for (var i = 0; i < versions.length; i += 2) {
      final left = versions[i];
      final right = i + 1 < versions.length ? versions[i + 1] : null;

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: VersionCard(version: left)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: right != null
                  ? VersionCard(version: right)
                  : const SizedBox(),
            ),
          ],
        ),
      );

      if (i + 2 < versions.length) {
        rows.add(const SizedBox(height: AppSpacing.sm));
      }
    }

    return Column(children: rows);
  }
}

// ── Grille narrow (1 colonne) ──
class _NarrowGrid extends StatelessWidget {
  final List versions;

  const _NarrowGrid({required this.versions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: versions
          .map(
            (v) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: VersionCard(version: v),
            ),
          )
          .toList(),
    );
  }
}
