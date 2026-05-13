/// Une expérience professionnelle affichée dans la section [CvExperience].
///
/// Les données proviennent de [CvContent.experiences].
class Experience {
  /// Nom de l'entreprise ou de la structure.
  final String company;

  /// Intitulé du poste occupé.
  final String role;

  /// Période de la mission (ex. "2021 — Présent").
  final String period;

  /// Lieu de la mission (ville).
  final String location;

  /// Description des responsabilités et réalisations.
  final String description;

  /// Technologies et compétences clés utilisées.
  final List<String> tags;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.description,
    required this.tags,
  });
}
