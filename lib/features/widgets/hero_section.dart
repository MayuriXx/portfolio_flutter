import 'package:flutter/material.dart';
import 'package:portfolio_flutter/shared/app_button.dart';
import '../../../theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onVersionsTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onVersionsTap,
    required this.onContactTap,
  });

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
          // Blob haut droite
          Positioned(
            top: -100,
            right: -100,
            child: _Blob(size: 500, color: AppColors.c3.withValues(alpha: 0.6)),
          ),

          // Blob bas gauche
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
                    _Eyebrow(),
                    const SizedBox(height: AppSpacing.lg),
                    _Title(),
                    const SizedBox(height: AppSpacing.lg),
                    isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: _Description()),
                              const SizedBox(width: AppSpacing.lg),
                              _Actions(
                                onVersionsTap: widget.onVersionsTap,
                                onContactTap: widget.onContactTap,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Description(),
                              const SizedBox(height: AppSpacing.md),
                              _Actions(
                                onVersionsTap: widget.onVersionsTap,
                                onContactTap: widget.onContactTap,
                              ),
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
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

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
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = AppColors.c2,
            ),
          ),
        ),
      ],
    );
  }
}

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

class _Actions extends StatelessWidget {
  final VoidCallback onVersionsTap;
  final VoidCallback onContactTap;

  const _Actions({required this.onVersionsTap, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppButton(
          label: 'Voir les versions',
          onTap: onVersionsTap,
          style: AppButtonStyle.dark,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Me contacter',
          onTap: onContactTap,
          style: AppButtonStyle.outline,
        ),
      ],
    );
  }
}
