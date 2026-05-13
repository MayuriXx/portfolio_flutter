import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/cv_provider.dart';
import '../../../theme/app_theme.dart';

class CvFooter extends ConsumerWidget {
  const CvFooter({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final isWide = MediaQuery.of(context).size.width > 768;
    final hPad = isWide ? AppSpacing.xxl : AppSpacing.md;

    return Container(
      color: const Color(0xFF111111),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 28),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FooterName(name: profile.name),
                _FooterLinks(onLaunch: _launch),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FooterName(name: profile.name),
                const SizedBox(height: AppSpacing.md),
                _FooterLinks(onLaunch: _launch),
              ],
            ),
    );
  }
}

// ── Nom ──
class _FooterName extends StatelessWidget {
  final String name;

  const _FooterName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$name · 2025',
      style: AppTextStyles.titleLarge.copyWith(
        fontSize: 14,
        color: Colors.white.withValues(alpha: 0.4),
      ),
    );
  }
}

// ── Liens ──
class _FooterLinks extends StatelessWidget {
  final Future<void> Function(String url) onLaunch;

  const _FooterLinks({required this.onLaunch});

  static const _links = [
    _FooterLink(label: 'Email', url: 'mailto:martho.evan@gmail.com'),
    _FooterLink(
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/in/evanmartho/',
    ),
    _FooterLink(label: 'GitHub', url: 'https://github.com/MayuriXx'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _links
          .map(
            (link) => Padding(
              padding: const EdgeInsets.only(left: AppSpacing.md),
              child: _FooterLinkItem(link: link, onLaunch: onLaunch),
            ),
          )
          .toList(),
    );
  }
}

// ── Item lien ──
class _FooterLinkItem extends StatefulWidget {
  final _FooterLink link;
  final Future<void> Function(String url) onLaunch;

  const _FooterLinkItem({required this.link, required this.onLaunch});

  @override
  State<_FooterLinkItem> createState() => _FooterLinkItemState();
}

class _FooterLinkItemState extends State<_FooterLinkItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onLaunch(widget.link.url),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.label.copyWith(
            color: _hovered
                ? Colors.white.withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.3),
            letterSpacing: 0.8,
          ),
          child: Text(widget.link.label),
        ),
      ),
    );
  }
}

// ── Modèle local ──
class _FooterLink {
  final String label;
  final String url;

  const _FooterLink({required this.label, required this.url});
}
