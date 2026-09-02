import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppWidth.s15),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.tealSoft : ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(AppRadius.s32),
        ),
        alignment: Alignment.center,
        child: Text(
          category,
          style: getRegularStyle(
            fontSize: FontSize.s14,
            fontFamily: FontConstants.interFamily,
            color: isSelected ? ColorManager.primaryText : ColorManager.secondaryText,
          ),
        ),
      ),
    );
  }
}
