import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_item.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_list_constants.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_list_item.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/index_bar_config.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/index_hint_bubble.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class AzTermsList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        onScrollNotification(notification);
        return false;
      },
      child: AzListView(
        data: azItems,
        itemCount: azItems.length,
        itemScrollController: scrollController,
        itemPositionsListener: positionsListener,
        padding: EdgeInsets.only(
          left: AppWidth.s16,
          right: AppWidth.s28,
          bottom: AppHeight.s16,
        ),
        itemBuilder: (context, index) => AzListItem(item: azItems[index]),
        susItemBuilder: (_, __) => const SizedBox.shrink(),
        susItemHeight: 0,
        indexBarData: AzListConstants.allLetters,
        indexBarWidth: AppWidth.s24,
        indexBarItemHeight: AppHeight.s18,
        indexBarAlignment: Alignment.centerRight,
        indexBarMargin: EdgeInsets.only(right: AppWidth.s4),
        indexBarOptions: AzIndexBarConfig(),
        indexHintBuilder:
            (context, hint) =>
                IndexHintBubble(hint: hint, onSelected: onLetterSelected),
      ),
    );
  }
}
