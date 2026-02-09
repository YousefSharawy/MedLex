import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

/// Category Chips List Widget
/// Horizontal scrolling category selector
class CategoryChipsList extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const List<String> _categories = [
    'All',
    'Anatomy',
    'Biochemistry',
    'Clinical Medicine',
    'Embryology',
    'Genetics',
    'Histology',
    'Immunology',
    'Laboratory Medicine',
    'Medical Terminology',
    'Microbiology',
    'Pathology',
    'Pharmacology',
    'Physiology',
    'Radiology',
  ];

  const CategoryChipsList({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.s32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => SizedBox(width: AppWidth.s10),
        itemBuilder: (context, index) {
          return _CategoryChip(
            category: _categories[index],
            isSelected: selectedCategory == _categories[index],
            onTap: () => onCategorySelected(_categories[index]),
          );
        },
      ),
    );
  }
}

/// Individual Category Chip
class _CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
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
          color: isSelected
              ? ColorManager.tealSoft
              : ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(AppRadius.s32),
        ),
        alignment: Alignment.center,
        child: Text(
          category,
          style: getRegularStyle(
            fontSize: FontSize.s14,
            fontFamily: FontConstants.interFamily,
            color: isSelected
                ? ColorManager.primaryText
                : ColorManager.secondaryText,
          ),
        ),
      ),
    );
  }
}