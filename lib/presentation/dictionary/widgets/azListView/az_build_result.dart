import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_item.dart';

class AzBuildResult {
  final List<AzItem> items;
  final Set<String> availableLetters;

  const AzBuildResult({
    required this.items,
    required this.availableLetters,
  });

  factory AzBuildResult.build(
    List<TermModel> terms, {
    required bool addLoadingIndicator,
  }) {
    if (terms.isEmpty) {
      return const AzBuildResult(items: [], availableLetters: {});
    }
    final grouped = <String, List<TermModel>>{};
    final availableLetters = <String>{};
    for (final term in terms) {
      final letter = AzItem.getFirstLetter(term.latinTerm);
      availableLetters.add(letter);
      (grouped[letter] ??= []).add(term);
    }
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => a == '#' ? -1 : (b == '#' ? 1 : a.compareTo(b)));
    final totalItems = terms.length + (addLoadingIndicator ? 1 : 0);
    final items = List<AzItem>.filled(totalItems, AzItem(tag: ''), growable: false);
    var index = 0;
    for (final letter in sortedKeys) {
      final letterTerms = grouped[letter]!
        ..sort((a, b) => a.latinTerm.compareTo(b.latinTerm));
      for (final term in letterTerms) {
        items[index++] = AzItem(term: term, tag: letter);
      }
    }
    if (addLoadingIndicator) {
      items[index] = AzItem(
        tag: index > 0 ? items[index - 1].tag : 'Z',
        isLoadingIndicator: true,
      );
    }

    return AzBuildResult(items: items, availableLetters: availableLetters);
  }
}