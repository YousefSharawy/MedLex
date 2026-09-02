import 'package:flutter/material.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_section_header.dart';

/// All content sections below the mode toggle:
/// definition, causes, symptoms, treatment.
/// Animates when [isSimpleMode] flips.

class DefinitionSection extends StatelessWidget {
  const DefinitionSection({super.key, 
    required this.term,
    required this.isSimpleMode,
  });

  final TermModel term;
  final bool isSimpleMode;

  @override
  Widget build(BuildContext context) {
    final text = isSimpleMode
        ? (term.simpleDefinition.isNotEmpty
            ? term.simpleDefinition
            : term.englishDefinition)
        : (term.academicDefinition.isNotEmpty
            ? term.academicDefinition
            : term.englishDefinition);

    return TermSectionHeader(
      title: 'Definition',
      child: Text(
        text,
        style: getRegularStyle(
          fontSize: FontSize.s14,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.darkGrey,
          height: 1.4,
        ),
      ),
    );
  }
}
