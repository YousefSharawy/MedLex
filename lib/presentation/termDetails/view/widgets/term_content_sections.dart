import 'package:flutter/material.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/values_manager.dart';

/// All content sections below the mode toggle:
/// definition, causes, symptoms, treatment.
/// Animates when [isSimpleMode] flips.
import 'definition_section.dart';
import 'section_with_bullets.dart';

class TermContentSections extends StatelessWidget {
  const TermContentSections({
    super.key,
    required this.term,
    required this.isSimpleMode,
  });

  final TermModel term;
  final bool isSimpleMode;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Column(
        key: ValueKey(isSimpleMode),
        children: [
          DefinitionSection(term: term, isSimpleMode: isSimpleMode),
          SizedBox(height: AppHeight.s16),
          if (term.causes != null && term.causes!.isNotEmpty)
            SectionWithBullets(title: 'Causes', text: term.causes!),
          if (term.symptoms != null && term.symptoms!.isNotEmpty)
            SectionWithBullets(title: 'Symptoms', text: term.symptoms!),
          if (term.treatment != null && term.treatment!.isNotEmpty)
            SectionWithBullets(title: 'Treatment', text: term.treatment!),
          if (term.differentialDiagnoses != null && term.differentialDiagnoses!.isNotEmpty)
            SectionWithBullets(
              title: 'Differential Diagnoses',
              text: term.differentialDiagnoses!,
            ),
        ],
      ),
    );
  }
}
