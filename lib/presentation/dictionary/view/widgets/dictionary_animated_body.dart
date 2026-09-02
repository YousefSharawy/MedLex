import 'package:flutter/material.dart';
import 'package:medlex/presentation/search/view/search_view.dart';
import 'package:medlex/app/resources/values_manager.dart';

class DictionaryAnimatedBody extends StatelessWidget {
  final bool isSearching;
  final bool searchEverOpened;
  final Widget dictionaryContent;

  const DictionaryAnimatedBody({
    super.key,
    required this.isSearching,
    required this.searchEverOpened,
    required this.dictionaryContent,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);

    return Stack(
      children: [
        AnimatedOpacity(
          duration: duration,
          opacity: isSearching ? 0.0 : 1.0,
          child: IgnorePointer(
            ignoring: isSearching,
            child: dictionaryContent,
          ),
        ),
        if (searchEverOpened)
          AnimatedOpacity(
            duration: duration,
            opacity: isSearching ? 1.0 : 0.0,
            child: IgnorePointer(
              ignoring: !isSearching,
              child: RepaintBoundary(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
                  child: const SearchView(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
