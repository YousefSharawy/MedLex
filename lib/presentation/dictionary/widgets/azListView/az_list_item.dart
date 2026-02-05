import 'package:flutter/material.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/az_item.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/letter_header.dart';
import 'package:transly/presentation/dictionary/widgets/azListView/term_tile.dart';

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