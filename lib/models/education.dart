/// Une formation affichée dans la section [CvEducation].
///
/// Les données proviennent de [CvContent.educations].
class Education {
  /// Intitulé du diplôme ou de la formation.
  final String degree;

  /// Nom de l'établissement.
  final String school;

  /// Période de la formation (ex. "2017 — 2019").
  final String period;

  const Education({
    required this.degree,
    required this.school,
    required this.period,
  });
}
