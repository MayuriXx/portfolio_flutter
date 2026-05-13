import '../models/profile.dart';
import '../models/experience.dart';
import '../models/education.dart';
import '../models/skill_group.dart';

class CvContent {
  CvContent._();

  static const profile = Profile(
    name: 'Evan Martho',
    title: 'Développeur Full Stack Mobile',
    summary:
        'Développeur mobile full stack expérimenté avec une expertise '
        'approfondie en Flutter, Java et Kotlin. J\'ai mené avec succès '
        'des projets internationaux, contribuant à fiabiliser les systèmes '
        'de gestion des stocks et commandes pour Leroy Merlin. Ma maîtrise '
        'des méthodologies agiles et des tests unitaires garantit des '
        'livrables robustes et évolutifs.',
    email: 'martho.evan@gmail.com',
    phone: '06 18 32 63 18',
    linkedin: 'https://www.linkedin.com/in/evanmartho/',
    location: 'Lille, France',
  );

  static const List<Experience> experiences = [
    Experience(
      company: 'XPEHO',
      role: 'Mobile App Developer — Lead Dev',
      period: '2021 — Présent',
      location: 'Villeneuve-d\'Ascq',
      description:
          'Missions longue durée chez Adéo (Leroy Merlin) dans le domaine '
          'ISO (In Store Operations). Rôles successifs de Développeur Front, '
          'Full-Stack puis Lead Dev sur des équipes internationales couvrant '
          'la France, l\'Espagne, l\'Italie et le Portugal. Développement '
          'd\'applications de fiabilisation des stocks et de gestion des '
          'commandes. Gestion des astreintes, MEP & publications techniques.',
      tags: [
        'Flutter',
        'Riverpod',
        'Kotlin',
        'Java',
        'Spring Boot',
        'Karate',
        'Agile',
        'Lead Dev',
      ],
    ),
    Experience(
      company: 'INEAT Group',
      role: 'Ingénieur Études & Développement Junior',
      period: '2019 — 2020',
      location: 'Lille',
      description:
          'Développement mobile multiplateforme via Flutter, intégration '
          'Firebase Analytics, architecture d\'une solution de migration de '
          'données from scratch. Consommation d\'APIs REST, SharePoint et '
          'Microsoft Graph. Implémentation de la couche réseau avec Chopper.',
      tags: ['Flutter', 'Firebase', 'REST API', 'Microsoft Graph', 'Chopper'],
    ),
    Experience(
      company: 'Enedis',
      role: 'Développeur Fullstack & Data',
      period: '2017 — 2019',
      location: 'Lille',
      description:
          'Conception et maintenance d\'applications métiers en équipe de '
          '6 développeurs via CodeIgniter. Optimisation des échanges via '
          'External Tables, scripts d\'insertion Bash et ordonnancement '
          'Crontab. Création de dashboards décisionnels sous Tableau Desktop.',
      tags: ['PHP CodeIgniter', 'SQL Server', 'Bash', 'Tableau Desktop'],
    ),
    Experience(
      company: 'Tata Steel',
      role: 'Développeur WinDev',
      period: '2016 — 2017',
      location: 'France',
      description:
          'Conception et évolution d\'applications métiers via WinDev et '
          'WebDev. Administration SQL Server, planification PERT, gestion '
          'salle serveur et stratégies de sauvegarde LTO.',
      tags: ['WinDev', 'WebDev', 'SQL Server', 'PERT'],
    ),
    Experience(
      company: 'Tôles Perforées de la Sambre',
      role: 'Technicien Informatique',
      period: '2014 — 2016',
      location: 'France',
      description:
          'Administration et exploitation du parc informatique, virtualisation '
          'serveurs, déploiement d\'outils. Développement d\'une application '
          'Java d\'automatisation documentaire (parsing ERP, conversion PDF, '
          'routage dynamique).',
      tags: ['Java', 'Virtualisation', 'Administration système'],
    ),
  ];

  static const List<SkillGroup> skillGroups = [
    SkillGroup(
      title: 'Mobile',
      skills: [
        'Flutter',
        'Riverpod',
        'Union Architecture',
        'Widget Tests',
        'Golden Tests',
        'Firebase',
      ],
    ),
    SkillGroup(
      title: 'Back-end',
      skills: [
        'Java',
        'Kotlin',
        'Spring Boot',
        'PHP',
        'REST API',
        'Karate Tests',
      ],
    ),
    SkillGroup(
      title: 'Data & BDD',
      skills: [
        'SQL Server',
        'Tableau Desktop',
        'External Tables',
        'Bash',
        'Crontab',
      ],
    ),
    SkillGroup(
      title: 'Méthodes & Outils',
      skills: ['Agile / Scrum', 'Figma', 'Miro', 'GitBook', 'Git', 'Lead Dev'],
    ),
    SkillGroup(
      title: 'Langues',
      skills: ['Français natif', 'Anglais avancé', 'Portugais débutant'],
    ),
    SkillGroup(
      title: 'Soft Skills',
      skills: [
        'Autonomie',
        'Travail en équipe',
        'International',
        'Communication',
        'Mentoring',
      ],
    ),
  ];

  static const List<Education> educations = [
    Education(
      degree: 'Master Informatique',
      school: 'Université Catholique de Lille — Ingénierie informatique',
      period: '2017 — 2019',
    ),
    Education(
      degree: 'Licence SIO',
      school: 'Université Polytechnique Hauts-de-France',
      period: '2016 — 2017',
    ),
    Education(
      degree: 'DUT Informatique',
      school: 'Université Polytechnique Hauts-de-France',
      period: '2014 — 2016',
    ),
    Education(
      degree: 'Bac STI2D',
      school: 'Lycée Théophile Legrand',
      period: '2011 — 2014',
    ),
  ];
}
