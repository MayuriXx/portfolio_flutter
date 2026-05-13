import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/cv_provider.dart';
import '../../../models/experience.dart';
import '../../../theme/app_theme.dart';

/// Section "Expérience" du CV (numéro 01).
///
/// Liste toutes les [Experience] issues de [experiencesProvider].
/// Adapte la mise en page selon la largeur d'écran (breakpoint 768 px).
class CvExperience extends ConsumerWidget {
  const CvExperience({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiences = ref.watch(experiencesProvider);
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
          // Header section
          _SectionHeader(number: '01', title: 'Expérience'),
          const SizedBox(height: AppSpacing.lg),

          // Liste des expériences
          ...experiences.map(
            (exp) => _ExperienceItem(experience: exp, isWide: isWide),
          ),
        ],
      ),
    );
  }
}

// ── Header de section ──
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

// ── Item expérience ──
class _ExperienceItem extends StatelessWidget {
  final Experience experience;
  final bool isWide;

  const _ExperienceItem({required this.experience, required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meta gauche
                SizedBox(
                  width: 200,
                  child: _ExperienceMeta(experience: experience),
                ),
                const SizedBox(width: AppSpacing.lg),

                // Contenu droite
                Expanded(child: _ExperienceContent(experience: experience)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ExperienceMeta(experience: experience),
                const SizedBox(height: AppSpacing.sm),
                _ExperienceContent(experience: experience),
              ],
            ),
    );
  }
}

// ── Meta : période + entreprise + lieu ──
class _ExperienceMeta extends StatelessWidget {
  final Experience experience;

  const _ExperienceMeta({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Période
        Text(
          experience.period,
          style: AppTextStyles.label.copyWith(
            color: AppColors.accent,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),

        // Entreprise
        Text(
          experience.company,
          style: AppTextStyles.titleLarge.copyWith(fontSize: 17),
        ),
        const SizedBox(height: 4),

        // Lieu
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 12,
              color: AppColors.inkLight,
            ),
            const SizedBox(width: 4),
            Text(
              experience.location,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.inkLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Contenu : rôle + description + tags ──
class _ExperienceContent extends StatelessWidget {
  final Experience experience;

  const _ExperienceContent({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rôle
        Text(
          experience.role,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.ink,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Description
        Text(experience.description, style: AppTextStyles.bodyMedium),
        const SizedBox(height: AppSpacing.sm),

        // Tags
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: experience.tags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.c4,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(tag, style: AppTextStyles.tag),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
