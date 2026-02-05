import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_item.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_list_constants.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_list_item.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/index_hint_bubble.dart';
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

  const AzTermsList({
    super.key,
    required this.azItems,
    required this.scrollController,
    required this.positionsListener,
    required this.onScrollNotification,
    required this.onLetterSelected,
  });

  @override
  State<AzTermsList> createState() => _AzTermsListState();
}

class _AzTermsListState extends State<AzTermsList> {
  String _activeLetter = '';
  String? _forcedLetter;

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
      oldWidget.positionsListener.itemPositions
          .removeListener(_onPositionsChanged);
      widget.positionsListener.itemPositions
          .addListener(_onPositionsChanged);
    }
  }

  void _onPositionsChanged() {
    if (_forcedLetter != null) return;

    final positions = widget.positionsListener.itemPositions.value;
    if (positions.isEmpty || widget.azItems.isEmpty) return;

    final firstVisible = positions
        .where((pos) => pos.itemTrailingEdge > 0)
        .reduce((a, b) =>
            a.itemTrailingEdge < b.itemTrailingEdge ? a : b);

    final index = firstVisible.index;
    if (index >= 0 && index < widget.azItems.length) {
      final tag = widget.azItems[index].getSuspensionTag();
      if (tag != _activeLetter) {
        setState(() => _activeLetter = tag);
      }
    }
  }

  void _onLetterTapped(String letter) {
    setState(() {
      _forcedLetter = letter;
      _activeLetter = letter;
    });

    widget.onLetterSelected(letter);

    Future.delayed(
      AzListConstants.scrollDuration + const Duration(milliseconds: 100),
      () {
        if (mounted) {
          setState(() => _forcedLetter = null);
        }
      },
    );
  }

  String get _displayLetter => _forcedLetter ?? _activeLetter;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        widget.onScrollNotification(notification);
        return false;
      },
      child: AzListView(
        data: widget.azItems,
        itemCount: widget.azItems.length,
        itemScrollController: widget.scrollController,
        itemPositionsListener: widget.positionsListener,
        padding: EdgeInsets.only(
          left: AppWidth.s16,
          right: AppWidth.s28,
          bottom: AppHeight.s16,
        ),
        itemBuilder: (context, index) =>
            AzListItem(item: widget.azItems[index]),
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
          selectItemDecoration: null,
          textStyle: getRegularStyle(
            fontSize: FontSize.s9,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primary,
          ),
          selectTextStyle: getRegularStyle(
            fontSize: FontSize.s9,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primary,
          ),
        ),
        indexHintBuilder: (context, hint) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _onLetterTapped(hint);
          });
          return IndexHintBubble(hint: hint, onSelected: (_) {});
        },
      ),
    );
  }
}