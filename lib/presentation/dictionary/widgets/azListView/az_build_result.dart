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

    final availableLetters = <String>{};
    final items = <AzItem>[];

    for (final term in terms) {
      final letter = AzItem.getFirstLetter(term.latinTerm);
      availableLetters.add(letter);
      items.add(AzItem(term: term, tag: letter));
    }

    if (addLoadingIndicator) {
      items.add(AzItem(
        tag: items.isNotEmpty ? items.last.tag : 'Z',
        isLoadingIndicator: true,
      ));
    }

    return AzBuildResult(items: items, availableLetters: availableLetters);
  }
}