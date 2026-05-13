import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cv_provider.dart';
import '../../../models/education.dart';
import '../../../theme/app_theme.dart';

class CvEducation extends ConsumerWidget {
  const CvEducation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final educations = ref.watch(educationsProvider);
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _SectionHeader(number: '03', title: 'Formation'),
          const SizedBox(height: AppSpacing.lg),

          // Grille
          isWide
              ? _WideGrid(educations: educations)
              : _NarrowGrid(educations: educations),
        ],
      ),
    );
  }
}

// ── Header ──
class _SectionHeader extends StatelessWidget {
  final String number;
  final String title;

  const _SectionHeader({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$number —',
          style: AppTextStyles.label.copyWith(fontSize: 12, letterSpacing: 0.1),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(title, style: AppTextStyles.displayMedium),
      ],
    );
  }
}

// ── Grille large (2 colonnes) ──
class _WideGrid extends StatelessWidget {
  final List<Education> educations;

  const _WideGrid({required this.educations});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var i = 0; i < educations.length; i += 2) {
      final left = educations[i];
      final right = i + 1 < educations.length ? educations[i + 1] : null;

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _EducationCard(education: left)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: right != null
                  ? _EducationCard(education: right)
                  : const SizedBox(),
            ),
          ],
        ),
      );

      if (i + 2 < educations.length) {
        rows.add(const SizedBox(height: AppSpacing.sm));
      }
    }

    return Column(children: rows);
  }
}

// ── Grille narrow (1 colonne) ──
class _NarrowGrid extends StatelessWidget {
  final List<Education> educations;

  const _NarrowGrid({required this.educations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: educations
          .map(
            (edu) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _EducationCard(education: edu),
            ),
          )
          .toList(),
    );
  }
}

// ── Card formation ──
class _EducationCard extends StatefulWidget {
  final Education education;

  const _EducationCard({required this.education});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _hovered
            ? Matrix4.translationValues(0, -3, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered ? AppColors.accent : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Période
            Text(
              widget.education.period,
              style: AppTextStyles.label.copyWith(
                color: AppColors.accent,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Diplôme
            Text(
              widget.education.degree,
              style: AppTextStyles.titleLarge.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 4),

            // École
            Text(
              widget.education.school,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.inkLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
