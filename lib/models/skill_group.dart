/// Un groupe de compétences affiché dans la section [CvSkills].
///
/// Regroupe plusieurs compétences par catégorie (Mobile, Back-end, etc.).
/// Les données proviennent de [CvContent.skillGroups].
class SkillGroup {
  /// Nom de la catégorie (ex. "Mobile", "Back-end").
  final String title;

  /// Liste des compétences appartenant à cette catégorie.
  final List<String> skills;

  const SkillGroup({required this.title, required this.skills});
}
