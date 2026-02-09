import 'package:flutter/material.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/termDetails/view/widgets/term_bullet_point.dart';
import 'package:transly/presentation/termDetails/view/widgets/term_section_header.dart';

/// All content sections below the mode toggle:
/// definition, causes, symptoms, treatment.
/// Animates when [isSimpleMode] flips.
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
          _DefinitionSection(term: term, isSimpleMode: isSimpleMode),
          SizedBox(height: AppHeight.s16),
          if (term.causes != null && term.causes!.isNotEmpty)
            _SectionWithBullets(title: 'Causes', text: term.causes!),
          if (term.symptoms != null && term.symptoms!.isNotEmpty)
            _SectionWithBullets(title: 'Symptoms', text: term.symptoms!),
          if (term.treatment != null && term.treatment!.isNotEmpty)
            _SectionWithBullets(title: 'Treatment', text: term.treatment!),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

class _DefinitionSection extends StatelessWidget {
  const _DefinitionSection({
    super.key,
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

/// A titled section that renders its [text] as bullet points when it
/// contains multiple items, or as a plain paragraph when it doesn't.
class _SectionWithBullets extends StatelessWidget {
  const _SectionWithBullets({
    super.key,
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
          child: _TermBulletList(text: text),
        ),
        SizedBox(height: AppHeight.s16),
      ],
    );
  }
}

/// Splits [text] on commas, semicolons, or newlines and renders each
/// item as a [TermBulletPoint]. Falls back to a plain [Text] when
/// there is only one item.
class _TermBulletList extends StatelessWidget {
  const _TermBulletList({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final items = text
        .split(RegExp(r'[,;\n]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (items.length <= 1) {
      return Text(
        text,
        style: getRegularStyle(
          fontSize: FontSize.s14,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.darkGrey,
          height: 1.4,
        ),
      );
    }

    return Column(
      children: items.map((item) => TermBulletPoint(text: item)).toList(),
    );
  }
}