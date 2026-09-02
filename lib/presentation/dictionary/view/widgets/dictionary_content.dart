import 'package:flutter/material.dart';
import 'package:medlex/presentation/dictionary/view/widgets/category_chip_list.dart';
import 'package:medlex/presentation/dictionary/view/widgets/terms_content_view.dart';
import 'package:medlex/app/resources/values_manager.dart';

class DictionaryContent extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const DictionaryContent({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryChipsList(
          selectedCategory: selectedCategory,
          onCategorySelected: onCategorySelected,
        ),
        SizedBox(height: AppHeight.s12),
        Expanded(child: TermsContentView(selectedCategory: selectedCategory)),
      ],
    );
  }
}
