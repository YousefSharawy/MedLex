import 'package:flutter/material.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_section_header.dart';

/// All content sections below the mode toggle:
/// definition, causes, symptoms, treatment.
/// Animates when [isSimpleMode] flips.
import 'term_bullet_list.dart';

class SectionWithBullets extends StatelessWidget {
  const SectionWithBullets({super.key, 
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TermSectionHeader(
          title: title,
          child: TermBulletList(text: text),
        ),
        SizedBox(height: AppHeight.s16),
      ],
    );
  }
}
