import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/cv_content.dart';
import '../models/profile.dart';
import '../models/experience.dart';
import '../models/education.dart';
import '../models/skill_group.dart';

final profileProvider = Provider<Profile>((ref) {
  return CvContent.profile;
});

final experiencesProvider = Provider<List<Experience>>((ref) {
  return CvContent.experiences;
});

final skillGroupsProvider = Provider<List<SkillGroup>>((ref) {
  return CvContent.skillGroups;
});

final educationsProvider = Provider<List<Education>>((ref) {
  return CvContent.educations;
});
