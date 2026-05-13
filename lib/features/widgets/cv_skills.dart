import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cv_provider.dart';
import '../../../models/skill_group.dart';
import '../../../theme/app_theme.dart';

/// Section "Compétences" du CV (numéro 02).
///
/// Affiche les [SkillGroup] issues de [skillGroupsProvider] en grille
/// de 3 colonnes (large) ou en pile verticale (mobile).
class CvSkills extends ConsumerWidget {
  const CvSkills({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillGroups = ref.watch(skillGroupsProvider);
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.accentPale,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _SectionHeader(number: '02', title: 'Compétences'),
          const SizedBox(height: AppSpacing.lg),

          // Grille
          isWide
              ? _WideGrid(skillGroups: skillGroups)
              : _NarrowGrid(skillGroups: skillGroups),
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

// ── Grille large (3 colonnes) ──
class _WideGrid extends StatelessWidget {
  final List<SkillGroup> skillGroups;

  const _WideGrid({required this.skillGroups});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var i = 0; i < skillGroups.length; i += 3) {
      final items = skillGroups.sublist(
        i,
        (i + 3).clamp(0, skillGroups.length),
      );

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...items.map(
              (group) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: items.last == group ? 0 : AppSpacing.sm,
                  ),
                  child: _SkillGroupCard(group: group),
                ),
              ),
            ),
            // Remplissage si ligne incomplète
            if (items.length < 3)
              ...List.generate(
                3 - items.length,
                (_) => const Expanded(child: SizedBox()),
              ),
          ],
        ),
      );

      if (i + 3 < skillGroups.length) {
        rows.add(const SizedBox(height: AppSpacing.sm));
      }
    }

    return Column(children: rows);
  }
}

// ── Grille narrow (1 colonne) ──
class _NarrowGrid extends StatelessWidget {
  final List<SkillGroup> skillGroups;

  const _NarrowGrid({required this.skillGroups});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: skillGroups
          .map(
            (group) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _SkillGroupCard(group: group),
            ),
          )
          .toList(),
    );
  }
}

// ── Card groupe de skills ──
class _SkillGroupCard extends StatelessWidget {
  final SkillGroup group;

  const _SkillGroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre du groupe
          Text(
            group.title,
            style: AppTextStyles.label.copyWith(
              color: AppColors.accent,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Skills
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: group.skills
                .map(
                  (skill) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.c4,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(skill, style: AppTextStyles.tag),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
