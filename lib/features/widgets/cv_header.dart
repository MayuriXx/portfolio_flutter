import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/cv_provider.dart';
import '../../../theme/app_theme.dart';

class CvHeader extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onExperienceTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onEducationTap;
  final VoidCallback onContactTap;

  const CvHeader({
    super.key,
    required this.scrollController,
    required this.onExperienceTap,
    required this.onSkillsTap,
    required this.onEducationTap,
    required this.onContactTap,
  });

  @override
  ConsumerState<CvHeader> createState() => _CvHeaderState();
}

class _CvHeaderState extends ConsumerState<CvHeader> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() => _isScrolled = widget.scrollController.offset > 20);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  Future<void> _launchEmail() async {
    final profile = ref.read(profileProvider);
    final uri = Uri(scheme: 'mailto', path: profile.email);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 60,
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.bg.withValues(alpha: 0.85)
            : AppColors.bg,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? AppColors.border : Colors.transparent,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nom
            Text(profile.name, style: AppTextStyles.titleLarge),

            // Nav
            Row(
              children: [
                _NavLink(label: 'Expérience', onTap: widget.onExperienceTap),
                _NavLink(label: 'Compétences', onTap: widget.onSkillsTap),
                _NavLink(label: 'Formation', onTap: widget.onEducationTap),
                const SizedBox(width: AppSpacing.xs),
                _ContactButton(onTap: widget.onContactTap),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Nav link ──
class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accentPale : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _hovered ? AppColors.border : Colors.transparent,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.bodySmall.copyWith(
              color: _hovered ? AppColors.ink : AppColors.inkMid,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Contact button ──
class _ContactButton extends StatefulWidget {
  final VoidCallback onTap;

  const _ContactButton({required this.onTap});

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFF5a7a6d) : AppColors.accent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            'Contact',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
