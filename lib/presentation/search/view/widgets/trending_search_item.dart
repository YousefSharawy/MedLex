import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class TrendingSearchItem extends StatelessWidget {
  const TrendingSearchItem({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: AppWidth.s8),
        padding: EdgeInsets.symmetric(horizontal: AppWidth.s12),
        decoration: BoxDecoration(
          color: ColorManager.tealSoft,
          borderRadius: BorderRadius.circular(AppRadius.s32),
        ),
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
      ),
    );
  }
}