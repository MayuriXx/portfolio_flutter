/// Informations de profil affichées dans le header et le hero du CV.
///
/// Données centralisées dans [CvContent.profile].
class Profile {
  /// Nom complet affiché dans le header et le hero.
  final String name;

  /// Intitulé de poste (ex. "Développeur Full Stack Mobile").
  final String title;

  /// Résumé court affiché dans la section hero.
  final String summary;

  /// Adresse e-mail pour les liens `mailto:`.
  final String email;

  /// URL du profil LinkedIn.
  final String linkedin;

  /// Ville et pays (ex. "Lille, France").
  final String location;

  const Profile({
    required this.name,
    required this.title,
    required this.summary,
    required this.email,
    required this.linkedin,
    required this.location,
  });
}
