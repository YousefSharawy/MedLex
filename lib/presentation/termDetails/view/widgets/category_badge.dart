import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

/// The term name row (with optional TTS button + category badge)
/// followed by the pronunciation line.

class CategoryBadge extends StatelessWidget {
  const CategoryBadge({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.s10,
        vertical: AppHeight.s7,
      ),
      decoration: BoxDecoration(
        color: ColorManager.tealSoft,
        borderRadius: BorderRadius.circular(AppRadius.s32),
      ),
      child: Text(
        category,
        style: getRegularStyle(
          fontSize: FontSize.s12,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.primaryText,
        ),
      ),
    );
  }
}
