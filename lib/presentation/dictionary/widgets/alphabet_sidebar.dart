import 'package:flutter/material.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/widgets/dictionary_utils.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

/// Alphabet Sidebar Widget
/// Provides A-Z quick navigation for the dictionary
class AlphabetSidebar extends StatelessWidget {
  final Map<String, List<TermModel>> groupedTerms;
  final ValueChanged<String> onLetterTap;

  const AlphabetSidebar({
    super.key,
    required this.groupedTerms,
    required this.onLetterTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppWidth.s24,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemHeight = (constraints.maxHeight /
                  DictionaryUtils.alphabet.length)
              .clamp(14.0, 22.0);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                DictionaryUtils.alphabet.map((letter) {
                  return _AlphabetLetter(
                    letter: letter,
                    itemHeight: itemHeight,
                    hasTerms: groupedTerms.containsKey(letter),
                    onTap: () => onLetterTap(letter),
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}

/// Individual Alphabet Letter
class _AlphabetLetter extends StatelessWidget {
  final String letter;
  final double itemHeight;
  final bool hasTerms;
  final VoidCallback onTap;

  const _AlphabetLetter({
    required this.letter,
    required this.itemHeight,
    required this.hasTerms,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: itemHeight,
        width: AppWidth.s24,
        alignment: Alignment.center,
        child: Text(
          letter,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            fontSize: FontSize.s10,
            fontFamily: FontConstants.interFamily,
            color:
                hasTerms
                    ? ColorManager.primary
                    : ColorManager.grey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
