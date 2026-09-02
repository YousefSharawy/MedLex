import 'package:flutter/material.dart';
import 'package:medlex/presentation/search/view/widgets/persistent_search_bar.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class DictionaryHeader extends StatelessWidget {
  final bool isSearching;
  final VoidCallback onSearchStart;
  final VoidCallback onSearchClose;

  const DictionaryHeader({
    super.key,
    required this.isSearching,
    required this.onSearchStart,
    required this.onSearchClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: isSearching
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              'Dictionary',
              style: getBoldStyle(
                fontSize: FontSize.s24,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primaryText,
              ),
            ),
            secondChild: Text(
              'Search',
              style: getBoldStyle(
                fontSize: FontSize.s24,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primaryText,
              ),
            ),
          ),
        ),
        SizedBox(height: AppHeight.s12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
          child: PersistentSearchBar(
            isSearching: isSearching,
            onSearchStart: onSearchStart,
            onSearchClose: onSearchClose,
          ),
        ),
      ],
    );
  }
}