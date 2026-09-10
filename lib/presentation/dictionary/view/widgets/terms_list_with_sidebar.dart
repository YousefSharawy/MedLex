import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:medlex/app/widgets/custom_loading_indicator.dart';
import 'package:medlex/app/widgets/toast_manager.dart';
import 'package:medlex/cubit/terms_cubit.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/presentation/dictionary/viewModel/cubit/az_list_cubit.dart';
import 'package:medlex/presentation/dictionary/view/widgets/azListView/az_list_constants.dart';
import 'package:medlex/presentation/dictionary/view/widgets/azListView/az_term_list.dart';
import 'package:medlex/app/resources/color_manager.dart';

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
  // Controllers — these are pure infrastructure, not state
  final _scrollController = ItemScrollController();
  final _positionsListener = ItemPositionsListener.create();
  final _azTermsListKey = GlobalKey<AzTermsListState>();

  // Debounce — not UI state, no cubit needed
  DateTime? _lastLoadTime;

  @override
  bool get wantKeepAlive => true;

  // ==================== LIFECYCLE ====================

  @override
  void initState() {
    super.initState();
    _prepareAzData();
  }

  @override
  void didUpdateWidget(TermsListWithSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    final categoryChanged =
        oldWidget.selectedCategory != widget.selectedCategory;
    final termsChanged = oldWidget.terms.length != widget.terms.length;
    final loadingStateChanged = oldWidget.hasMore != widget.hasMore;

    if (categoryChanged) {
      context.read<AzListCubit>().invalidateCache();
    }
    if (categoryChanged || termsChanged || loadingStateChanged) {
      _prepareAzData();
    }
  }

  // ==================== DATA PREPARATION ====================

  void _prepareAzData() {
    context.read<AzListCubit>().prepareAzData(
      terms: widget.terms,
      selectedCategory: widget.selectedCategory,
      hasMore: widget.hasMore,
      isAllCategory: widget.isAllCategory,
    );
  }

  // ==================== SCROLLING ====================

  void _scrollToLetter(String letter) {
    final termsCubit = context.read<TermsCubit>();
    final azCubit = context.read<AzListCubit>();

    if (termsCubit.pendingLetter == letter) return;

    if (azCubit.state.availableLetters.contains(letter)) {
      azCubit.setNavigating(true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _scrollToLetterDirectly(letter, azCubit.state.azItems);
        Future.delayed(AzListConstants.scrollDuration, () {
          if (mounted) azCubit.setNavigating(false);
        });
      });
      return;
    }

    if (!widget.isAllCategory) {
      _showLetterNotFoundMessage(letter);
      return;
    }

    if (widget.hasMore) {
      azCubit.setNavigating(true);
      termsCubit.loadTermsUntilLetter(letter);
    } else {
      _showLetterNotFoundMessage(letter);
    }
  }

  void _scrollToLetterDirectly(String letter, List azItems) {
    if (!_scrollController.isAttached) return;
    final index = azItems.indexWhere(
      (item) => item.getSuspensionTag() == letter && !item.isLoadingIndicator,
    );
    if (index != -1) {
      _scrollController.scrollTo(
        index: index,
        duration: AzListConstants.scrollDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  void _showLetterNotFoundMessage(String letter) {
    final location = widget.isAllCategory ? 'found' : 'in this category';
    final target = letter == '#'
        ? 'prefixes or suffixes'
        : 'terms starting with "$letter"';
    ToastManager.show(
      context, message: 'No $target $location.');
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (!widget.isAllCategory || !widget.hasMore || widget.isLoadingMore) {
      return;
    }
    if (notification is! ScrollEndNotification) return;

    final metrics = notification.metrics;
    final reachedThreshold =
        metrics.pixels >= metrics.maxScrollExtent * AzListConstants.loadThreshold;
    if (!reachedThreshold) return;

    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!) < AzListConstants.loadDebounce) {
      return;
    }
    _lastLoadTime = now;
    widget.onLoadMore();
  }

  // ==================== TERMS CUBIT LISTENER ====================

  bool _shouldListenTerms(TermsState previous, TermsState current) {
    if (current is! AllTermsLoaded) return false;
    if (previous is! AllTermsLoaded) return true;
    return previous.pendingLetter != current.pendingLetter ||
        previous.letterJustLoaded != current.letterJustLoaded;
  }

  void _onTermsStateChanged(BuildContext context, TermsState state) {
  if (state is! AllTermsLoaded) return;
  final azCubit = context.read<AzListCubit>();

  if (state.letterJustLoaded != null) {
    azCubit.invalidateCache();
    _prepareAzData(); // triggers BlocBuilder rebuild with new azItems
    final letter = state.letterJustLoaded!;
    final termsCubit = context.read<TermsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        // Now azCubit.state.azItems is the fresh list
        _scrollToLetterDirectly(letter, azCubit.state.azItems);
        Future.delayed(AzListConstants.scrollDuration, () {
          if (mounted) {
            azCubit.setNavigating(false);
            termsCubit.clearLetterJustLoaded();
            _azTermsListKey.currentState?.onScrollToLetterComplete(letter);
          }
        });
      });
    });
    return;
  }
        if (state.pendingLetter == null) {
      azCubit.setNavigating(false);
    }
  }

  // ==================== BUILD ====================

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // TermsCubit listener only — drives scroll + navigation side-effects.
    // Never triggers a rebuild (buildWhen: false).
    return BlocConsumer<TermsCubit, TermsState>(
      listenWhen: _shouldListenTerms,
      listener: _onTermsStateChanged,
      buildWhen: (_, __) => false,
      builder: (_, __) {
        return BlocBuilder<AzListCubit, AzListState>(
          builder: (context, azState) {
            return Stack(
              children: [
                IgnorePointer(
                  ignoring: azState.isNavigating,
                  child: AzTermsList(
                    key: _azTermsListKey,
                    azItems: azState.azItems,
                    scrollController: _scrollController,
                    positionsListener: _positionsListener,
                    onScrollNotification: _handleScrollNotification,
                    onLetterSelected: _scrollToLetter,
                    isAllCategory: widget.isAllCategory,
                    hasMore: widget.hasMore,
                  ),
                ),
                if (azState.isNavigating)
                  Positioned.fill(
                    child: ColoredBox(
                      color: ColorManager.background.withAlpha(70),
                      child: const Center(child: CustomLoadingIndicator()),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}