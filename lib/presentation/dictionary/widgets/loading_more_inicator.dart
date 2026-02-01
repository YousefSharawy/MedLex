import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

/// Loading More Indicator
/// Shows loading state at the bottom of the list during pagination
class LoadingMoreIndicator extends StatelessWidget {
  final bool isLoadingMore;

  const LoadingMoreIndicator({
    super.key,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppHeight.s16),
      child: Center(
        child: isLoadingMore
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ColorManager.primary,
                ),
              )
            : Text(
                'Loading more...',
                style: getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.secondaryText,
                ),
              ),
      ),
    );
  }
}