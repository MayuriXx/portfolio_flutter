import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import 'widgets/cv_header.dart';
import 'widgets/cv_hero.dart';
import 'widgets/cv_experience.dart';
import 'widgets/cv_skills.dart';
import 'widgets/cv_education.dart';
import 'widgets/cv_contact.dart';
import 'widgets/cv_footer.dart';

/// Page principale du CV, assemblée en stack.
///
/// Contient un [SingleChildScrollView] avec toutes les sections :
/// [CvHero], [CvExperience], [CvSkills], [CvEducation], [CvContact], [CvFooter].
///
/// Un [CvHeader] fixe est superposé via un [Positioned].
/// La navigation interne utilise des [GlobalKey] et [Scrollable.ensureVisible].
class CvPage extends ConsumerStatefulWidget {
  const CvPage({super.key});

  @override
  ConsumerState<CvPage> createState() => _CvPageState();
}

class _CvPageState extends ConsumerState<CvPage> {
  final _scrollController = ScrollController();

  // GlobalKeys pour la navigation
  final _experienceKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _contactKey = GlobalKey();

  /// Scrolle de façon animée vers le widget associé à [key].
  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Contenu scrollable
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Espace header fixe
                const SizedBox(height: 60),

                // Hero
                CvHero(onContactTap: () => _scrollTo(_contactKey)),

                // Expérience
                KeyedSubtree(key: _experienceKey, child: const CvExperience()),

                // Compétences
                KeyedSubtree(key: _skillsKey, child: const CvSkills()),

                // Formation
                KeyedSubtree(key: _educationKey, child: const CvEducation()),

                // Contact
                KeyedSubtree(key: _contactKey, child: const CvContact()),

                // Footer
                const CvFooter(),
              ],
            ),
          ),

          // Header fixe par dessus
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CvHeader(
              scrollController: _scrollController,
              onExperienceTap: () => _scrollTo(_experienceKey),
              onSkillsTap: () => _scrollTo(_skillsKey),
              onEducationTap: () => _scrollTo(_educationKey),
              onContactTap: () => _scrollTo(_contactKey),
            ),
          ),
        ],
      ),
    );
  }
}
