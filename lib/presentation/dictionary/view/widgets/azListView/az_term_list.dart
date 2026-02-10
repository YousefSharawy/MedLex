import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:transly/presentation/dictionary/view/widgets/azListView/az_item.dart';
import 'package:transly/presentation/dictionary/view/widgets/azListView/az_list_constants.dart';
import 'package:transly/presentation/dictionary/view/widgets/azListView/az_list_item.dart';
import 'package:transly/presentation/dictionary/view/widgets/azListView/index_hint_bubble.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class AzTermsList extends StatefulWidget {
  final List<AzItem> azItems;
  final ItemScrollController scrollController;
  final ItemPositionsListener positionsListener;
  final void Function(ScrollNotification) onScrollNotification;
  final void Function(String) onLetterSelected;
  final bool isAllCategory;
  final bool hasMore;

  const AzTermsList({
    super.key,
    required this.azItems,
    required this.scrollController,
    required this.positionsListener,
    required this.onScrollNotification,
    required this.onLetterSelected,
    required this.isAllCategory,
    required this.hasMore,
  });

  @override
  State<AzTermsList> createState() => AzTermsListState();
}

class AzTermsListState extends State<AzTermsList> {
  String _activeLetter = '';
  String? _forcedLetter;
  bool _waitingForLetterLoad = false;

  @override
  void initState() {
    super.initState();
    widget.positionsListener.itemPositions.addListener(_onPositionsChanged);
  }

  @override
  void dispose() {
    widget.positionsListener.itemPositions.removeListener(_onPositionsChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(AzTermsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.positionsListener != widget.positionsListener) {
      oldWidget.positionsListener.itemPositions.removeListener(
        _onPositionsChanged,
      );
      widget.positionsListener.itemPositions.addListener(_onPositionsChanged);
    }

    // When new items arrive and we were waiting for a letter,
    // check if the forced letter is now available
    if (_waitingForLetterLoad &&
        _forcedLetter != null &&
        oldWidget.azItems.length != widget.azItems.length) {
      final hasLetter = widget.azItems.any(
        (item) =>
            item.getSuspensionTag() == _forcedLetter &&
            !item.isLoadingIndicator,
      );
      if (hasLetter) {
        _waitingForLetterLoad = false;
      }
    }
  }

  void _onPositionsChanged() {
    // Don't update active letter while forced letter is set
    if (_forcedLetter != null) return;

    final positions = widget.positionsListener.itemPositions.value;
    if (positions.isEmpty || widget.azItems.isEmpty) return;

    final firstVisible = positions
        .where((pos) => pos.itemTrailingEdge > 0)
        .reduce((a, b) => a.itemTrailingEdge < b.itemTrailingEdge ? a : b);

    final index = firstVisible.index;
    if (index >= 0 && index < widget.azItems.length) {
      final tag = widget.azItems[index].getSuspensionTag();
      if (tag != _activeLetter) {
        setState(() => _activeLetter = tag);
      }
    }
  }

  void _onLetterTapped(String letter) {
    final isAvailableLocally = widget.azItems.any(
      (item) => item.getSuspensionTag() == letter && !item.isLoadingIndicator,
    );

    if (isAvailableLocally) {
      // Letter exists — force it and scroll
      setState(() {
        _forcedLetter = letter;
        _activeLetter = letter;
        _waitingForLetterLoad = false;
      });
      widget.onLetterSelected(letter);
      _releaseForceAfterScroll();
      return;
    }

    if (widget.isAllCategory && widget.hasMore) {
      // Letter not loaded yet but can be fetched — force it and wait
      setState(() {
        _forcedLetter = letter;
        _activeLetter = letter;
        _waitingForLetterLoad = true;
      });
      widget.onLetterSelected(letter);
      return;
    }

    // Letter doesn't exist in this category — don't force, just notify parent
    widget.onLetterSelected(letter);
  }

  void _releaseForceAfterScroll() {
    Future.delayed(
      AzListConstants.scrollDuration + const Duration(milliseconds: 150),
      () {
        if (mounted && _forcedLetter != null) {
          setState(() {
            _activeLetter = _forcedLetter!;
            _forcedLetter = null;
          });
        }
      },
    );
  }

  /// Called by parent after scroll to a remotely loaded letter completes
  void onScrollToLetterComplete(String letter) {
    if (mounted && _forcedLetter == letter) {
      _releaseForceAfterScroll();
    }
  }

  String get displayLetter => _forcedLetter ?? _activeLetter;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        widget.onScrollNotification(notification);
        return false;
      },
      child: Stack(
        children: [
          AzListView(
            data: widget.azItems,
            itemCount: widget.azItems.length,
            itemScrollController: widget.scrollController,
            itemPositionsListener: widget.positionsListener,
            padding: EdgeInsets.only(
              left: AppWidth.s16,
              right: AppWidth.s28,
              bottom: AppHeight.s16,
            ),
            itemBuilder:
                (context, index) => AzListItem(item: widget.azItems[index]),
            susItemBuilder: (_, __) => const SizedBox.shrink(),
            susItemHeight: 0,
            indexBarData: AzListConstants.allLetters,
            indexBarWidth: AppWidth.s24,
            indexBarItemHeight: AppHeight.s18,
            indexBarAlignment: Alignment.centerRight,
            indexBarMargin: EdgeInsets.only(right: AppWidth.s4),
            indexBarOptions: IndexBarOptions(
              hapticFeedback: true,
              needRebuild: true,
              indexHintAlignment: Alignment.centerRight,
              indexHintOffset: const Offset(-20, 0),
              selectItemDecoration: const BoxDecoration(), // disabled
              textStyle: getRegularStyle(
                fontSize: FontSize.s9,
                fontFamily: FontConstants.interFamily,
                color: Colors.transparent, // hide library text
              ),
              selectTextStyle: getRegularStyle(
                fontSize: FontSize.s9,
                fontFamily: FontConstants.interFamily,
                color: Colors.transparent, // hide library text
              ),
            ),
            indexHintBuilder: (context, hint) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _onLetterTapped(hint);
              });
              return IndexHintBubble(hint: hint, onSelected: (_) {});
            },
          ),
          // Our own letter overlay — controlled by displayLetter
          Positioned(
            right: AppWidth.s4,
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      AzListConstants.allLetters.map((letter) {
                        final isActive = displayLetter == letter;
                        final isAvailable = widget.azItems.any(
                          (item) =>
                              item.getSuspensionTag() == letter &&
                              !item.isLoadingIndicator,
                        );
                        return SizedBox(
                          height: AppHeight.s18,
                          width: AppWidth.s24,
                          child: Center(
                            child: Container(
                              height: AppHeight.s18,
                              width: AppWidth.s20,
                              alignment: Alignment.center,
                              decoration:
                                  isActive
                                      ? BoxDecoration(
                                        color: ColorManager.primary.withOpacity(
                                          0.15,
                                        ),
                                        shape: BoxShape.circle,
                                      )
                                      : null,
                              child: Text(
                                letter,
                                style: getRegularStyle(
                                  fontSize: FontSize.s9,
                                  fontFamily: FontConstants.interFamily,
                                  color:
                                      (isAvailable || widget.hasMore)
                                          ? ColorManager.primary
                                          : ColorManager.primary.withOpacity(
                                            0.25,
                                          ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
