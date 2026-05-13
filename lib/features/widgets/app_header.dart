import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // Écoute le scroll pour l'effet blur
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollable = Scrollable.maybeOf(context);
      scrollable?.position.addListener(_onScroll);
    });
  }

  void _onScroll() {
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) return;
    final offset = scrollable.position.pixels;
    setState(() => _isScrolled = offset > 20);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 60,
      decoration: BoxDecoration(
        color: _isScrolled ? AppColors.bg.withOpacity(0.85) : AppColors.bg,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? AppColors.border : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Text('Evan Martho', style: AppTextStyles.titleLarge),

            // Nav
            Row(
              children: [
                _NavLink(label: 'Versions', anchor: '#versions'),
                _NavLink(label: 'Philosophie', anchor: '#philosophy'),
                const SizedBox(width: AppSpacing.xs),
                _ContactButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final String anchor;

  const _NavLink({required this.label, required this.anchor});

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
        onTap: () {
          // Scroll vers l'ancre — géré via GlobalKey dans meta_page
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        },
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

class _ContactButton extends StatefulWidget {
  const _ContactButton();

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
        onTap: () {
          // Ouvre le client mail
        },
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
