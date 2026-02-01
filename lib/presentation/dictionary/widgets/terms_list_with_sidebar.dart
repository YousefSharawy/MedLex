import 'package:flutter/material.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/widgets/dictionary_utils.dart';
import 'package:transly/presentation/dictionary/widgets/terms_grouped_list.dart';
import 'package:transly/presentation/dictionary/widgets/alphabet_sidebar.dart';

class TermsListWithSidebar extends StatefulWidget {
  final List<TermModel> terms;
  final String selectedCategory;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  const TermsListWithSidebar({
    super.key,
    required this.terms,
    required this.selectedCategory,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
  });

  @override
  State<TermsListWithSidebar> createState() => _TermsListWithSidebarState();
}

class _TermsListWithSidebarState extends State<TermsListWithSidebar> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _letterKeys = {};

  // Cached grouped terms
  Map<String, List<TermModel>> _cachedGroupedTerms = {};
  List<String> _cachedAvailableLetters = [];

  @override
  void initState() {
    super.initState();
    _initializeLetterKeys();
    _scrollController.addListener(_onScroll);
    _rebuildCache();
  }

  @override
  void didUpdateWidget(TermsListWithSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.terms != widget.terms) {
      _rebuildCache();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeLetterKeys() {
    for (var letter in DictionaryUtils.alphabet) {
      _letterKeys[letter] = GlobalKey();
    }
  }

  void _rebuildCache() {
    _cachedGroupedTerms = DictionaryUtils.groupTermsByLetter(widget.terms);
    _cachedAvailableLetters = _cachedGroupedTerms.keys.toList();
  }

  void _onScroll() {
    if (widget.selectedCategory != 'All') return;
    if (!widget.hasMore) return;
    if (widget.isLoadingMore) return;

    final position = _scrollController.position;
    final threshold = position.maxScrollExtent * 0.85;

    if (position.pixels >= threshold) {
      widget.onLoadMore();
    }
  }

  void _scrollToLetter(String letter) {
    if (!_cachedGroupedTerms.containsKey(letter)) {
      DictionaryUtils.showLetterNotAvailableMessage(
        letter: letter,
        selectedCategory: widget.selectedCategory,
        hasMore: widget.hasMore,
      );
      return;
    }

    final key = _letterKeys[letter];
    final keyContext = key?.currentContext;

    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TermsGroupedList(
            scrollController: _scrollController,
            groupedTerms: _cachedGroupedTerms,
            availableLetters: _cachedAvailableLetters,
            letterKeys: _letterKeys,
            selectedCategory: widget.selectedCategory,
            hasMore: widget.hasMore,
            isLoadingMore: widget.isLoadingMore,
          ),
        ),
        AlphabetSidebar(
          groupedTerms: _cachedGroupedTerms,
          onLetterTap: _scrollToLetter,
        ),
      ],
    );
  }
}
