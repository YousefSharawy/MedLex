import 'package:flutter/material.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/widgets/letter_section.dart';
import 'package:transly/presentation/dictionary/widgets/loading_more_inicator.dart';
import 'package:transly/presentation/resources/values_manager.dart';

/// Terms Grouped List
/// Displays terms grouped by letter in a scrollable list
class TermsGroupedList extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, List<TermModel>> groupedTerms;
  final List<String> availableLetters;
  final Map<String, GlobalKey> letterKeys;
  final String selectedCategory;
  final bool hasMore;
  final bool isLoadingMore;

  const TermsGroupedList({
    super.key,
    required this.scrollController,
    required this.groupedTerms,
    required this.availableLetters,
    required this.letterKeys,
    required this.selectedCategory,
    required this.hasMore,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    final showLoadingIndicator = selectedCategory == 'All' && (hasMore || isLoadingMore);
    final itemCount = availableLetters.length + (showLoadingIndicator ? 1 : 0);

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        left: AppWidth.s16,
        right: AppWidth.s4,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Build letter sections
        if (index < availableLetters.length) {
          final letter = availableLetters[index];
          final letterTerms = groupedTerms[letter]!;
          return LetterSection(
            key: letterKeys[letter],
            letter: letter,
            terms: letterTerms,
          );
        }

        // Loading indicator at the end
        if (showLoadingIndicator) {
          return LoadingMoreIndicator(isLoadingMore: isLoadingMore);
        }

        return const SizedBox.shrink();
      },
    );
  }
}