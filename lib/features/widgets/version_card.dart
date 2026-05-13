import 'package:flutter/material.dart';
import '../../../models/version.dart';
import '../../../theme/app_theme.dart';

class VersionCard extends StatefulWidget {
  final Version version;

  const VersionCard({super.key, required this.version});

  @override
  State<VersionCard> createState() => _VersionCardState();
}

class _VersionCardState extends State<VersionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovered
            ? (Matrix4.translationValues(0.0, -4.0, 0.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? widget.version.color : AppColors.border,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    blurRadius: 48,
                    offset: const Offset(0, 16),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Contenu principal
              Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Head : icône + badge
                    _CardHead(version: widget.version),
                    const SizedBox(height: AppSpacing.md),

                    // Nom
                    Text(
                      widget.version.name,
                      style: AppTextStyles.displaySmall.copyWith(
                        fontSize: 30,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Description
                    Text(
                      widget.version.description,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Tags
                    _TagsWrap(tags: widget.version.tags),
                    const SizedBox(height: AppSpacing.md),

                    // Footer : liens ou soon
                    _CardFooter(version: widget.version, hovered: _hovered),
                  ],
                ),
              ),

              // Barre colorée en bas au hover
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: _hovered
                        ? LinearGradient(
                            colors: [
                              widget.version.color,
                              widget.version.color.withValues(alpha: 0.5),
                            ],
                          )
                        : const LinearGradient(
                            colors: [Colors.transparent, Colors.transparent],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Head : icône + badge ──
class _CardHead extends StatelessWidget {
  final Version version;

  const _CardHead({required this.version});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Icône
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.c4,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Center(
            child: Text(version.icon, style: const TextStyle(fontSize: 24)),
          ),
        ),

        // Badge
        _StatusBadge(status: version.status),
      ],
    );
  }
}

// ── Badge statut ──
class _StatusBadge extends StatelessWidget {
  final VersionStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isLive = status == VersionStatus.live;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: isLive
            ? const Color(0xFF2D9E6B).withValues(alpha: 0.08)
            : AppColors.accentPale,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isLive
              ? const Color(0xFF2D9E6B).withValues(alpha: 0.25)
              : AppColors.border,
        ),
      ),
      child: Text(
        isLive ? 'Live' : 'En cours',
        style: AppTextStyles.label.copyWith(
          color: isLive ? const Color(0xFF2D9E6B) : AppColors.inkLight,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ── Tags ──
class _TagsWrap extends StatelessWidget {
  final List<String> tags;

  const _TagsWrap({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.c4,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(tag, style: AppTextStyles.tag),
            ),
          )
          .toList(),
    );
  }
}

// ── Footer ──
class _CardFooter extends StatelessWidget {
  final Version version;
  final bool hovered;

  const _CardFooter({required this.version, required this.hovered});

  @override
  Widget build(BuildContext context) {
    if (!version.isLive) {
      return Text(
        'Bientôt disponible',
        style: AppTextStyles.bodySmall.copyWith(
          fontStyle: FontStyle.italic,
          color: AppColors.inkLight,
        ),
      );
    }

    return Row(
      children: [
        if (version.url != null)
          _CardLink(
            label: 'Voir la démo →',
            url: version.url!,
            color: version.color,
          ),
        if (version.url != null && version.githubUrl != null)
          const SizedBox(width: AppSpacing.md),
        if (version.githubUrl != null)
          _CardLink(
            label: 'GitHub →',
            url: version.githubUrl!,
            color: AppColors.inkLight,
          ),
      ],
    );
  }
}

// ── Lien ──
class _CardLink extends StatefulWidget {
  final String label;
  final String url;
  final Color color;

  const _CardLink({
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<_CardLink> createState() => _CardLinkState();
}

class _CardLinkState extends State<_CardLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // url_launcher géré dans meta_page
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _hovered ? 0.7 : 1.0,
          child: Text(
            widget.label,
            style: AppTextStyles.bodySmall.copyWith(
              color: widget.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
