import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class EmptyHint extends StatelessWidget {
  const EmptyHint({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppHeight.s8),
      child: Text(
        text,
        style: getRegularStyle(
          fontSize: FontSize.s12,
          color: ColorManager.secondaryText.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
