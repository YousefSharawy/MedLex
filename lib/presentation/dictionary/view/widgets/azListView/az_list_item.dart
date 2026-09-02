import 'package:flutter/material.dart';
import 'package:medlex/app/ui_utils.dart';
import 'package:medlex/presentation/dictionary/view/widgets/azListView/az_item.dart';
import 'package:medlex/presentation/dictionary/view/widgets/azListView/letter_header.dart';
import 'package:medlex/presentation/dictionary/view/widgets/azListView/term_tile.dart';

class AzListItem extends StatelessWidget {
  final AzItem item;

  const AzListItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    if (item.isLoadingIndicator) {
      return  UiUtils.loadingWidget();
    }

    if (item.isShowSuspension) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LetterHeader(letter: item.getSuspensionTag()),
          TermTile(term: item.term!),
        ],
      );
    }
    return TermTile(term: item.term!);
  }
}