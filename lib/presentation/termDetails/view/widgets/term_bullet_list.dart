import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_bullet_point.dart';

/// All content sections below the mode toggle:
/// definition, causes, symptoms, treatment.
/// Animates when [isSimpleMode] flips.

class TermBulletList extends StatelessWidget {
  const TermBulletList({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final items = text
        .split(RegExp(r'[,;\n]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (items.length <= 1) {
      return Text(
        text,
        style: getRegularStyle(
          fontSize: FontSize.s14,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.darkGrey,
          height: 1.4,
        ),
      );
    }

    return Column(
      children: items.map((item) => TermBulletPoint(text: item)).toList(),
    );
  }
}
