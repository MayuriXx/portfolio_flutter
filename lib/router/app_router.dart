import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_flutter/features/cv_page.dart';

/// Instance GoRouter exposée via Riverpod.
///
/// Routes :
/// - `/` → [CvPage] (transition fade 400 ms)
///
/// Affiche [NotFoundPage] sur toute route inconnue.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: 'cv',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CvPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const NotFoundPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    ),
  );
});

/// Page affichée sur toute route inconnue (erreur 404).
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FFF8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF6B9080),
                fontSize: 80,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Page introuvable',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF4A6358)),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text(
                'Retour à l\'accueil',
                style: TextStyle(color: Color(0xFF6B9080)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
