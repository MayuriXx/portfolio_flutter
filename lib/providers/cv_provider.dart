import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/cv_data.dart';
import '../models/version.dart';

// Liste complète des versions
final versionsProvider = Provider<List<Version>>((ref) {
  return CvData.versions;
});

// Versions live uniquement
final liveVersionsProvider = Provider<List<Version>>((ref) {
  return ref.watch(versionsProvider).where((v) => v.isLive).toList();
});

// Une version par id
final versionByIdProvider = Provider.family<Version?, String>((ref, id) {
  return ref.watch(versionsProvider).where((v) => v.id == id).firstOrNull;
});

// Points de philosophie
final philosophyProvider = Provider<List<PhilosophyPoint>>((ref) {
  return CvData.philosophyPoints;
});
