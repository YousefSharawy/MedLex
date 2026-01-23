import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class TrendingSearchItem extends StatelessWidget {
  const TrendingSearchItem({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: AppWidth.s8),

      decoration: BoxDecoration(
        color: ColorManager.tealSoft,
        borderRadius: BorderRadius.circular(AppRadius.s32),
      ),
      width: AppWidth.s71,
      height: AppHeight.s32,
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            fontSize: FontSize.s12,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primaryText,
          ),
        ),
      ),
    );
  }
}
