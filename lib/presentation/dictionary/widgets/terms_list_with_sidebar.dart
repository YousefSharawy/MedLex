import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_build_result.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_item.dart';
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
  // Controllers
  final _scrollController = ItemScrollController();
  final _positionsListener = ItemPositionsListener.create();

  // Data
  List<AzItem> _azItems = [];
  Set<String> _availableLettersSet = {};

  // Cache
  static List<TermModel>? _cachedAllTerms;
  static String? _lastCategory;

  // Debounce
  DateTime? _lastLoadTime;

  @override
  bool get wantKeepAlive => true;

  // ==================== LIFECYCLE ====================

  @override
  void initState() {
    super.initState();
    _initializeCache();
    _prepareAzData();
  }

  @override
  void didUpdateWidget(TermsListWithSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    final categoryChanged = oldWidget.selectedCategory != widget.selectedCategory;
    final termsChanged = oldWidget.terms.length != widget.terms.length;
    final loadingStateChanged = oldWidget.hasMore != widget.hasMore ||
        oldWidget.isLoadingMore != widget.isLoadingMore;

    if (categoryChanged) {
      _lastCategory = widget.selectedCategory;
      _prepareAzData();
    } else if (termsChanged || loadingStateChanged) {
      if (widget.isAllCategory) _cachedAllTerms = List.from(widget.terms);
      _prepareAzData(skipSetState: true);
    }
  }

  // ==================== DATA PREPARATION ====================

  void _initializeCache() {
    if (widget.isAllCategory && _cachedAllTerms == null) {
      _cachedAllTerms = List.from(widget.terms);
    }
    _lastCategory = widget.selectedCategory;
  }

  void _prepareAzData({bool skipSetState = false}) {
    final terms = widget.isAllCategory 
        ? (_cachedAllTerms ?? widget.terms) 
        : widget.terms;
    
    final result = AzBuildResult.build(
      terms,
      addLoadingIndicator: widget.isAllCategory && widget.hasMore,
    );

    if (skipSetState) {
      _azItems = result.items;
      _availableLettersSet = result.availableLetters;
    } else {
      setState(() {
        _azItems = result.items;
        _availableLettersSet = result.availableLetters;
      });
    }

    if (_azItems.isNotEmpty) {
      SuspensionUtil.setShowSuspensionStatus(_azItems);
    }
  }

  // ==================== SCROLLING ====================

  void _scrollToLetter(String letter) {
    final cubit = context.read<AppCubit>();

    if (cubit.pendingLetter == letter) return;

    if (_availableLettersSet.contains(letter)) {
      Future.microtask(() => _scrollToLetterDirectly(letter));
      return;
    }

    if (!widget.isAllCategory) {
      _showLetterNotFoundMessage(letter);
      return;
    }

    if (widget.hasMore) {
      cubit.loadTermsUntilLetter(letter);
    } else {
      _showLetterNotFoundMessage(letter);
    }
  }

  void _scrollToLetterDirectly(String letter) {
    final index = _azItems.indexWhere(
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
    UiUtils.showInfoMessage('No $target $location.');
  }

  // ==================== SCROLL HANDLING ====================

  void _handleScrollNotification(ScrollNotification notification) {
    if (!widget.isAllCategory || !widget.hasMore || widget.isLoadingMore) return;

    final isScrollEvent = notification is ScrollEndNotification || 
                          notification is ScrollUpdateNotification;
    if (!isScrollEvent) return;

    final metrics = notification.metrics;
    final reachedThreshold = metrics.pixels >= 
        metrics.maxScrollExtent * AzListConstants.loadThreshold;
    
    if (!reachedThreshold) return;

    // Debounce
    final now = DateTime.now();
    if (_lastLoadTime != null && 
        now.difference(_lastLoadTime!) < AzListConstants.loadDebounce) {
      return;
    }

    _lastLoadTime = now;
    widget.onLoadMore();
  }

  // ==================== BLOC LISTENER ====================

  bool _shouldListen(AppState previous, AppState current) {
    if (current is! AllTermsLoaded) return false;
    if (previous is! AllTermsLoaded) return current.letterJustLoaded != null;

    // Handle loading dialog
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

  void _onStateChanged(BuildContext context, AppState state) {
    if (state is! AllTermsLoaded || state.letterJustLoaded == null) return;

    if (widget.isAllCategory) {
      _cachedAllTerms = List.from(widget.terms);
    }

    final letter = state.letterJustLoaded!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _scrollToLetterDirectly(letter);
        context.read<AppCubit>().clearLetterJustLoaded();
      }
    });
  }

  // ==================== BUILD ====================

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<AppCubit, AppState>(
      listenWhen: _shouldListen,
      listener: _onStateChanged,
      buildWhen: (_, __) => false,
      builder: (_, __) => AzTermsList(
        azItems: _azItems,
        scrollController: _scrollController,
        positionsListener: _positionsListener,
        onScrollNotification: _handleScrollNotification,
        onLetterSelected: _scrollToLetter,
      ),
    );
  }
}