# Portfolio Flutter — Evan Martho

> Version Flutter du portfolio multi-technologie. Le même CV, construit en Flutter Web, Vue.js, React et Angular pour démontrer l'adaptabilité technique.

## Présentation

Ce projet est l'une des quatre versions du portfolio d'Evan Martho, toutes partageant les mêmes données (`CvContent`) et le même design system (couleurs, typographies, espacements). Chaque version est déployée indépendamment sur son propre sous-domaine.

| Version | Stack | Statut |
| ------- | ----- | ------ |
| Flutter | Dart · Flutter Web · Riverpod | Ce repo |
| Vue.js | Vue 3 · Composition API · Vite | [Live](https://mayurixx.github.io/portfolio-vue/) |
| React | React 18 · Hooks · Vite | Bientôt |
| Angular | Angular 17 · TypeScript · RxJS | Bientôt |

---

## Stack technique

- **Framework** : Flutter Web (rendu canvas natif)
- **State management** : Riverpod (`Provider`, `ConsumerWidget`)
- **Routing** : GoRouter (transitions fade, page 404)
- **Typographie** : Google Fonts — Syne (titres) · Instrument Sans (corps)
- **CI/CD** : GitHub Actions → GitHub Pages

---

## Architecture

```text
lib/
├── main.dart                  # Point d'entrée, ProviderScope + MaterialApp.router
├── data/
│   └── cv_content.dart        # Source unique de vérité (profil, expériences, compétences, formations)
├── models/
│   ├── profile.dart           # Modèle profil
│   ├── experience.dart        # Modèle expérience professionnelle
│   ├── education.dart         # Modèle formation
│   └── skill_group.dart       # Modèle groupe de compétences
├── providers/
│   └── cv_provider.dart       # Providers Riverpod exposant les données CvContent
├── router/
│   └── app_router.dart        # Configuration GoRouter + page 404
├── theme/
│   └── app_theme.dart         # Design tokens : AppColors, AppSpacing, AppTextStyles, AppTheme
├── shared/
│   └── app_button.dart        # Bouton réutilisable (dark / outline) avec hover
└── features/
    ├── cv_page.dart           # Page principale (scaffold + scroll controller)
    └── widgets/
        ├── cv_header.dart     # Header sticky avec effet blur au scroll
        ├── cv_hero.dart       # Section hero (nom, titre, résumé)
        ├── cv_experience.dart # Section expériences professionnelles
        ├── cv_skills.dart     # Section compétences par groupe
        ├── cv_education.dart  # Section formations
        ├── cv_contact.dart    # Section contact (email, LinkedIn)
        └── cv_footer.dart     # Pied de page
```

---

## Mise à jour du CV

Toutes les données sont centralisées dans [`lib/data/cv_content.dart`](lib/data/cv_content.dart). Une seule modification met à jour l'ensemble du site.

```dart
// Modifier le profil
static const profile = Profile(
  name: 'Evan Martho',
  email: 'martho.evan@gmail.com',
  // ...
);

// Ajouter une expérience
static const List<Experience> experiences = [
  Experience(
    company: 'Nouvelle entreprise',
    role: 'Mon rôle',
    // ...
  ),
];
```

---

## Lancer le projet

**Prérequis** : Flutter SDK ≥ 3.11.5 (Dart ≥ 3.11.5)

```bash
# Installer les dépendances
flutter pub get

# Lancer en développement (Chrome)
flutter run -d chrome

# Build de production
flutter build web --base-href /portfolio-flutter/
```

---

## Déploiement

Le déploiement est automatisé via GitHub Actions (`.github/workflows/deploy.yml`).

**Déclencheur** : chaque `push` sur la branche `main`

**Étapes** :

1. Checkout du repo
2. Setup Flutter 3.27.0 (stable)
3. `flutter pub get`
4. `flutter build web --base-href /portfolio-flutter/`
5. Publication du dossier `build/web` sur la branche `gh-pages` via `peaceiris/actions-gh-pages`

Le secret `GITHUB_TOKEN` est fourni automatiquement par GitHub Actions — aucune configuration manuelle requise.

**URL de production** : `https://mayurixx.github.io/portfolio-flutter/`

---

## Design system

Défini dans [`lib/theme/app_theme.dart`](lib/theme/app_theme.dart).

| Token | Valeur |
| ----- | ------ |
| `AppColors.bg` | `#F6FFF8` (blanc cassé vert) |
| `AppColors.ink` | `#1E2A25` (presque noir) |
| `AppColors.accent` | `#6B9080` (vert sauge foncé) |
| `AppSpacing.sm` | 16 px |
| `AppSpacing.md` | 24 px |
| `AppSpacing.lg` | 48 px |
| `AppSpacing.xl` | 80 px |
| `AppSpacing.xxl` | 120 px |
