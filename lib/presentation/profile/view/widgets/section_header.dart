import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppWidth.s20),
      child: Text(
        label,
        style: getBoldStyle(
          fontSize: FontSize.s15,
          fontFamily: FontConstants.interFamily,
          color: ColorManager.graySecondaryText,
        ),
      ),
    );
  }
}
