import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class ConceptBand extends StatelessWidget {
  const ConceptBand({super.key});

  static const _stats = [
    _Stat(number: '4', label: 'Technos'),
    _Stat(number: '1', label: 'Design'),
    _Stat(number: '1', label: 'JSON'),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      color: AppColors.accent,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpacing.lg),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _ConceptText()),
                const SizedBox(width: AppSpacing.lg),
                _StatsRow(stats: _stats),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ConceptText(),
                const SizedBox(height: AppSpacing.md),
                _StatsRow(stats: _stats),
              ],
            ),
    );
  }
}

// ── Texte ──
class _ConceptText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.titleLarge.copyWith(
          color: Colors.white,
          height: 1.4,
        ),
        children: const [
          TextSpan(text: 'Un seul fichier de données. '),
          TextSpan(
            text: 'Quatre façons de le lire, de le structurer, de le rendre. ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: Color(0xBFFFFFFF), // white 75%
            ),
          ),
          TextSpan(
            text:
                'Le même résultat visuel — des philosophies techniques radicalement différentes.',
          ),
        ],
      ),
    );
  }
}

// ── Ligne de stats ──
class _StatsRow extends StatelessWidget {
  final List<_Stat> stats;

  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stats
          .map(
            (s) => Padding(
              padding: const EdgeInsets.only(right: AppSpacing.lg),
              child: _StatItem(stat: s),
            ),
          )
          .toList(),
    );
  }
}

// ── Item stat ──
class _StatItem extends StatelessWidget {
  final _Stat stat;

  const _StatItem({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          stat.number,
          style: AppTextStyles.displaySmall.copyWith(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stat.label,
          style: AppTextStyles.label.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

// ── Modèle local ──
class _Stat {
  final String number;
  final String label;

  const _Stat({required this.number, required this.label});
}
