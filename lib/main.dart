import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Point d'entrée de l'application.
///
/// Enveloppe l'application dans un [ProviderScope] Riverpod.
void main() {
  runApp(const ProviderScope(child: App()));
}

/// Racine de l'application.
///
/// Configure le [MaterialApp.router] avec le thème [AppTheme] et le
/// routeur GoRouter exposé par [routerProvider].
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Evan Martho — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: router,
    );
  }
}
