import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
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

    // Lance l'animation à l'apparition
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Stack(
        children: [
          // Blob décoratif haut droite
          Positioned(
            top: -100,
            right: -100,
            child: _Blob(size: 500, color: AppColors.c3.withValues(alpha: 0.6)),
          ),

          // Blob décoratif bas gauche
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Eyebrow
                    _Eyebrow(),
                    const SizedBox(height: AppSpacing.lg),

                    // Titre
                    _Title(),
                    const SizedBox(height: AppSpacing.lg),

                    // Bottom : desc + actions
                    isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: _Description()),
                              const SizedBox(width: AppSpacing.lg),
                              _Actions(),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Description(),
                              const SizedBox(height: AppSpacing.md),
                              _Actions(),
                            ],
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

// ── Blob décoratif ──
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
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}

// ── Eyebrow ──
class _Eyebrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 32, height: 1, color: AppColors.accent),
        const SizedBox(width: 10),
        Text('Même CV · 4 technologies', style: AppTextStyles.label),
      ],
    );
  }
}

// ── Titre ──
class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width > 768 ? 100.0 : 60.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Evan',
          style: AppTextStyles.displayLarge.copyWith(fontSize: fontSize),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.c2, AppColors.c3],
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            'Martho',
            style: AppTextStyles.displayLarge.copyWith(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Description ──
class _Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: Text(
        'Développeur Full Stack Mobile. Ce site est lui-même un projet — '
        'le même CV, construit en Flutter, Vue.js, React et Angular pour '
        'démontrer l\'adaptabilité technique.',
        style: AppTextStyles.bodyLarge,
      ),
    );
  }
}

// ── Actions ──
class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _AppButton(
          label: 'Voir les versions',
          onTap: () {},
          style: _AppButtonStyle.dark,
        ),
        const SizedBox(height: AppSpacing.sm),
        _AppButton(
          label: 'Me contacter',
          onTap: () {},
          style: _AppButtonStyle.outline,
        ),
      ],
    );
  }
}

// ── Bouton réutilisable ──
enum _AppButtonStyle { dark, outline }

class _AppButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final _AppButtonStyle style;

  const _AppButton({
    required this.label,
    required this.onTap,
    required this.style,
  });

  @override
  State<_AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<_AppButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.style == _AppButtonStyle.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: _hovered
              ? (Matrix4.identity()..translateByDouble(0.0, -2.0, 0.0, 0.0))
              : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
          decoration: BoxDecoration(
            color: isDark
                ? (_hovered ? const Color(0xFF2e3d38) : AppColors.ink)
                : (_hovered ? AppColors.surface : AppColors.surface),
            borderRadius: BorderRadius.circular(100),
            border: isDark
                ? null
                : Border.all(
                    color: _hovered ? AppColors.accentMid : AppColors.border,
                    width: 1.5,
                  ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark
                  ? Colors.white
                  : (_hovered ? AppColors.ink : AppColors.inkMid),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
