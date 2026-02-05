import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/cubit/az_list_cubit.dart';
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

  // Data - LOCAL STATE
  List<AzItem> _azItems = [];
  Set<String> _availableLettersSet = {};

  // Debounce
  DateTime? _lastLoadTime;

  // Track if loading dialog is showing to avoid duplicate calls
  bool _isLoadingDialogShowing = false;

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
      _prepareAzData();
    } else if (termsChanged || loadingStateChanged) {
      _prepareAzData(skipSetState: true);
    }
  }

  // ==================== DATA PREPARATION ====================

  void _prepareAzData({bool skipSetState = false}) {
    final result = context.read<AzListCubit>().buildAzItems(
          terms: widget.terms,
          selectedCategory: widget.selectedCategory,
          hasMore: widget.hasMore,
          isAllCategory: widget.isAllCategory,
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

    // Only check on scroll end, not every frame
    if (notification is! ScrollEndNotification) return;

    final metrics = notification.metrics;
    final reachedThreshold =
        metrics.pixels >= metrics.maxScrollExtent * AzListConstants.loadThreshold;

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

  // ==================== LOADING DIALOG ====================

  void _showLoadingDialog() {
    if (!_isLoadingDialogShowing) {
      _isLoadingDialogShowing = true;
      UiUtils.showLoading(context);
    }
  }

  void _hideLoadingDialog() {
    if (_isLoadingDialogShowing) {
      _isLoadingDialogShowing = false;
      UiUtils.hideLoading(context);
    }
  }

  // ==================== BLOC LISTENER ====================

  bool _shouldListen(AppState previous, AppState current) {
    if (current is! AllTermsLoaded) return false;
    if (previous is! AllTermsLoaded) return true;

    final pendingChanged = previous.pendingLetter != current.pendingLetter;
    final letterLoaded =
        previous.letterJustLoaded != current.letterJustLoaded &&
            current.letterJustLoaded != null;

    return pendingChanged || letterLoaded;
  }

  void _onStateChanged(BuildContext context, AppState state) {
    if (state is! AllTermsLoaded) return;

    // Handle loading dialog
    if (state.pendingLetter != null) {
      _showLoadingDialog();
    } else {
      _hideLoadingDialog();
    }

    // Handle letter just loaded
    if (state.letterJustLoaded == null) return;

    // Invalidate cache since new terms were loaded
    context.read<AzListCubit>().invalidateCache();
    _prepareAzData();

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