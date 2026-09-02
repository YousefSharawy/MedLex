import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class TermSectionHeader extends StatelessWidget {
  const TermSectionHeader({super.key, required this.child, required this.title});
 final Widget child;
 final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppWidth.s16),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.black.withAlpha(25),
        ),
        color:  ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.s12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getBoldStyle(
              fontSize: FontSize.s16,
              fontFamily: FontConstants.arialFamily,
              color: ColorManager.primaryText,
            ),
          ),
          SizedBox(height: AppHeight.s20),
          child,
        ],
      ),
    );
  }
}
