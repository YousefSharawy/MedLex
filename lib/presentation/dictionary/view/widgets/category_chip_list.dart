import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

/// Category Chips List Widget
/// Horizontal scrolling category selector
class CategoryChipsList extends StatefulWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const List<String> _categories = [
   'All',
  "Anatomy",
  "Biochemistry",
  "Biophysics",
  "Cardiology",
  "Cellular & Molecular Biology",
  "Chemistry",
  "Clinical Medicine",
  "Dental Anatomy",
  "Dental Terminology",
  "Dermatology",
  "Diagnostics",
  "Embryology",
  "Endocrinology",
  "First Aid",
  "Gastroenterology",
  "Genetics",
  "Gynecology & Obstetrics",
  "Hematology",
  "Histology",
  "Immunology",
  "Infection Control",
  "Infectious Diseases",
  "Laboratory Medicine",
  "Medical Terminology",
  "Microbiology",
  "Nephrology",
  "Neurology",
  "Neuroscience",
  "Oncology",
  "Ophthalmology",
  "Orthopedics",
  "Pathology",
  "Pediatrics",
  "Pharmacology",
  "Physiology",
  "Psychiatry",
  "Public Health & Epidemiology",
  "Pulmonology",
  "Radiology",
  "Rheumatology",
  "Surgery",
  "Urology"
  ];

  const CategoryChipsList({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoryChipsList> createState() => _CategoryChipsListState();
}

class _CategoryChipsListState extends State<CategoryChipsList> {
    final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = List.generate(
    CategoryChipsList._categories.length,
    (_) => GlobalKey(),
  );
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  void _scrollToSelected(int index) {
    final context = _keys[index].currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      alignment: 0.1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.s32,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
        itemCount: CategoryChipsList._categories.length,
        separatorBuilder: (_, __) => SizedBox(width: AppWidth.s10),
        itemBuilder: (context, index) {
          return _CategoryChip(
            key: _keys[index],
            category: CategoryChipsList._categories[index],
            isSelected: widget.selectedCategory == CategoryChipsList._categories[index],
            onTap: ()  {widget.onCategorySelected(CategoryChipsList._categories[index]);
            _scrollToSelected(index);
            },
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