import 'package:transly/domain/models.dart';
import 'package:transly/app/ui_utiles.dart';

/// Dictionary Utilities
/// Helper functions for dictionary operations
class DictionaryUtils {
  DictionaryUtils._();

  static const List<String> alphabet = [
    '#',
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  ];

  static Map<String, List<TermModel>> groupTermsByLetter(
    List<TermModel> terms,
  ) {
    final Map<String, List<TermModel>> groupedTerms = {};

    for (var letter in alphabet) {
      final letterTerms = getTermsForLetter(terms, letter);
      if (letterTerms.isNotEmpty) {
        groupedTerms[letter] = letterTerms;
      }
    }

    return groupedTerms;
  }

  static List<TermModel> getTermsForLetter(
    List<TermModel> terms,
    String letter,
  ) {
    if (letter == '#') {
      return terms.where((term) {
        if (term.latinTerm.isEmpty) return false;
        final firstChar = term.latinTerm[0].toUpperCase();
        return !RegExp(r'^[A-Z]$').hasMatch(firstChar);
      }).toList();
    }

    return terms
        .where((term) => term.latinTerm.toUpperCase().startsWith(letter))
        .toList();
  }

  static void showLetterNotAvailableMessage({
    required String letter,
    required String selectedCategory,
    required bool hasMore,
  }) {
    final String message;

    if (selectedCategory == 'All') {
      if (hasMore) {
        message = letter == '#'
            ? 'Prefixes/suffixes not loaded yet. Scroll down to load more.'
            : 'Terms starting with "$letter" not loaded yet. Scroll down to load more.';
      } else {
        message = letter == '#'
            ? 'No prefixes or suffixes found in dictionary.'
            : 'No terms starting with "$letter" found in dictionary.';
      }
    } else {
      // In specific category tab
      message = letter == '#'
          ? 'No prefixes or suffixes in $selectedCategory.'
          : 'No terms starting with "$letter" in $selectedCategory.';
    }

    UiUtils.showInfoMessage(message);
  }
}