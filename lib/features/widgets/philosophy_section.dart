import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cv_provider.dart';
import '../../../data/cv_data.dart';
import '../../../theme/app_theme.dart';

class PhilosophySection extends ConsumerWidget {
  const PhilosophySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(philosophyProvider);
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      color: AppColors.accentPale,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpacing.xl),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _PhilosophyLeft()),
                const SizedBox(width: AppSpacing.xl),
                Expanded(child: _PhilosophyPoints(points: points)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PhilosophyLeft(),
                const SizedBox(height: AppSpacing.lg),
                _PhilosophyPoints(points: points),
              ],
            ),
    );
  }
}

// ── Partie gauche ──
class _PhilosophyLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Une archi,\nquatre fois.', style: AppTextStyles.displayMedium),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Les choix techniques derrière ce projet reflètent la façon dont '
          "j'aborde chaque mission : rigueur, lisibilité et séparation des "
          'responsabilités.',
          style: AppTextStyles.bodyLarge,
        ),
      ],
    );
  }
}

// ── Liste des points ──
class _PhilosophyPoints extends StatelessWidget {
  final List<PhilosophyPoint> points;

  const _PhilosophyPoints({required this.points});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: points
          .map((point) => _PhilosophyPointItem(point: point))
          .toList(),
    );
  }
}

// ── Item ──
class _PhilosophyPointItem extends StatelessWidget {
  final PhilosophyPoint point;

  const _PhilosophyPointItem({required this.point});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numéro
          SizedBox(
            width: 28,
            child: Text(
              point.number,
              style: AppTextStyles.label.copyWith(color: AppColors.accentMid),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Texte
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.ink),
                children: [
                  TextSpan(
                    text: point.bold,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                  TextSpan(text: point.text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
