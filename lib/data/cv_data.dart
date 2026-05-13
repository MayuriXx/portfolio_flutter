import 'package:flutter/material.dart';
import '../models/version.dart';

class CvData {
  CvData._();

  static const List<Version> versions = [
    Version(
      id: 'flutter',
      name: 'Flutter',
      icon: '🐦',
      color: Color(0xFF54C5F8),
      status: VersionStatus.soon,
      url: null,
      githubUrl: null,
      description:
          'Rendu canvas natif via Flutter Web. Architecture Riverpod, '
          'widget tests et golden tests. La version qui sort du lot — '
          'un CV rendu par un moteur mobile.',
      tags: ['Dart', 'Flutter Web', 'Riverpod', 'Canvas', 'Golden Tests'],
    ),
    Version(
      id: 'vue',
      name: 'Vue.js',
      icon: '💚',
      color: Color(0xFF2D9E6B),
      status: VersionStatus.live,
      url: 'https://mayurixx.github.io/portfolio-vue/',
      githubUrl: 'https://github.com/MayuriXx/portfolio-vue',
      description:
          'Composition API, Vue Router, Vite. Données centralisées en JSON. '
          'Architecture légère et maintenable — la version la plus lisible '
          'pour un dev front.',
      tags: ['Vue 3', 'Composition API', 'Vite', 'JSON data'],
    ),
    Version(
      id: 'react',
      name: 'React',
      icon: '⚛️',
      color: Color(0xFF1A8FA8),
      status: VersionStatus.soon,
      url: null,
      githubUrl: null,
      description:
          'Hooks, Context API, composants fonctionnels. L\'approche la plus '
          'demandée du marché, exécutée avec rigueur.',
      tags: ['React 18', 'Hooks', 'Context API', 'Vite'],
    ),
    Version(
      id: 'angular',
      name: 'Angular',
      icon: '🔴',
      color: Color(0xFFC0392B),
      status: VersionStatus.soon,
      url: null,
      githubUrl: null,
      description:
          'Architecture modulaire, services injectables, typage TypeScript '
          'strict, RxJS. La version enterprise-grade plébiscitée dans les '
          'grands groupes et ESN.',
      tags: ['Angular 17', 'TypeScript', 'Services', 'RxJS'],
    ),
  ];

  static const List<PhilosophyPoint> philosophyPoints = [
    PhilosophyPoint(
      number: '01',
      bold: 'Source unique de vérité',
      text:
          ' — toutes les versions lisent le même cv.json. '
          'Une mise à jour, quatre sites synchronisés.',
    ),
    PhilosophyPoint(
      number: '02',
      bold: 'Design token partagé',
      text:
          ' — couleurs, typographies et espacements définis une fois, '
          'traduits dans chaque techno.',
    ),
    PhilosophyPoint(
      number: '03',
      bold: 'Déploiement indépendant',
      text:
          ' — chaque version sur son propre sous-domaine. '
          'Zéro couplage entre les implémentations.',
    ),
    PhilosophyPoint(
      number: '04',
      bold: 'Code source ouvert',
      text:
          ' — chaque version a son repo GitHub documenté. '
          'Le code parle autant que le CV.',
    ),
  ];
}

class PhilosophyPoint {
  final String number;
  final String bold;
  final String text;

  const PhilosophyPoint({
    required this.number,
    required this.bold,
    required this.text,
  });
}
