import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/cubit/az_list_cubit.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_list_constants.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_term_list.dart';

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

  bool get isAllCategory => selectedCategory == 'All';

  @override
  State<TermsListWithSidebar> createState() => _TermsListWithSidebarState();
}

class _TermsListWithSidebarState extends State<TermsListWithSidebar>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ItemScrollController();
  final _positionsListener = ItemPositionsListener.create();
  DateTime? _lastLoadTime;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<AzListCubit>().initialize(
      terms: widget.terms,
      selectedCategory: widget.selectedCategory,
      hasMore: widget.hasMore,
      isAllCategory: widget.isAllCategory,
    );
  }

  @override
  void didUpdateWidget(TermsListWithSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    final categoryChanged =
        oldWidget.selectedCategory != widget.selectedCategory;
    final termsChanged = oldWidget.terms.length != widget.terms.length;
    final loadingStateChanged =
        oldWidget.hasMore != widget.hasMore ||
        oldWidget.isLoadingMore != widget.isLoadingMore;

    if (categoryChanged || termsChanged || loadingStateChanged) {
      context.read<AzListCubit>().updateTerms(
        terms: widget.terms,
        selectedCategory: widget.selectedCategory,
        hasMore: widget.hasMore,
        isAllCategory: widget.isAllCategory,
      );
    }
  }

  void _handleLetterSelected(String letter, Set<String> availableLetters) {
    final appCubit = context.read<AppCubit>();

    if (appCubit.pendingLetter == letter) return;

    if (availableLetters.contains(letter)) {
      context.read<AzListCubit>().requestScrollToLetter(letter);
      return;
    }

    if (!widget.isAllCategory) {
      _showLetterNotFoundMessage(letter);
      return;
    }

    if (widget.hasMore) {
      appCubit.loadTermsUntilLetter(letter);
    } else {
      _showLetterNotFoundMessage(letter);
    }
  }

  void _scrollToIndex(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: AzListConstants.scrollDuration,
      curve: Curves.easeInOut,
    );
  }

  void _showLetterNotFoundMessage(String letter) {
    final location = widget.isAllCategory ? 'found' : 'in this category';
    final target =
        letter == '#'
            ? 'prefixes or suffixes'
            : 'terms starting with "$letter"';
    UiUtils.showInfoMessage('No $target $location.');
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (!widget.isAllCategory || !widget.hasMore || widget.isLoadingMore)
      return;

    final isScrollEvent =
        notification is ScrollEndNotification ||
        notification is ScrollUpdateNotification;
    if (!isScrollEvent) return;

    final metrics = notification.metrics;
    final reachedThreshold =
        metrics.pixels >=
        metrics.maxScrollExtent * AzListConstants.loadThreshold;

    if (!reachedThreshold) return;

    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!) < AzListConstants.loadDebounce) {
      return;
    }

    _lastLoadTime = now;
    widget.onLoadMore();
  }

  bool _shouldListenToAppCubit(AppState previous, AppState current) {
    if (current is! AllTermsLoaded) return false;
    if (previous is! AllTermsLoaded) return current.letterJustLoaded != null;

    if (previous.pendingLetter != current.pendingLetter) {
      if (current.pendingLetter != null) {
        UiUtils.showLoading(context);
      } else {
        UiUtils.hideLoading(context);
      }
    }

    return previous.letterJustLoaded != current.letterJustLoaded &&
        current.letterJustLoaded != null;
  }

  void _onAppStateChanged(BuildContext context, AppState state) {
    if (state is! AllTermsLoaded || state.letterJustLoaded == null) return;

    if (widget.isAllCategory) {
      context.read<AzListCubit>().updateCache(widget.terms);
    }

    final letter = state.letterJustLoaded!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AzListCubit>().requestScrollToLetter(letter);
        context.read<AppCubit>().clearLetterJustLoaded();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AppCubit, AppState>(
          listenWhen: _shouldListenToAppCubit,
          listener: _onAppStateChanged,
        ),
        BlocListener<AzListCubit, AzListState>(
          listener: (context, state) {
            state.whenOrNull(
              scrollToLetter: (_, __, ___, ____, targetIndex) {
                _scrollToIndex(targetIndex);
              },
            );
          },
        ),
      ],
      child: BlocBuilder<AzListCubit, AzListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loaded: (azItems, availableLetters, selectedCategory, _) {
              return AzTermsList(
                azItems: azItems,
                scrollController: _scrollController,
                positionsListener: _positionsListener,
                onScrollNotification: _handleScrollNotification,
                onLetterSelected:
                    (letter) => _handleLetterSelected(letter, availableLetters),
              );
            },
            scrollToLetter: (
              azItems,
              availableLetters,
              selectedCategory,
              _,
              __,
            ) {
              return AzTermsList(
                azItems: azItems,
                scrollController: _scrollController,
                positionsListener: _positionsListener,
                onScrollNotification: _handleScrollNotification,
                onLetterSelected:
                    (letter) => _handleLetterSelected(letter, availableLetters),
              );
            },
          );
        },
      ),
    );
  }
}
