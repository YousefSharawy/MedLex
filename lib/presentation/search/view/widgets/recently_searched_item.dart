import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class RecentlySearchedItem extends StatelessWidget {
  const RecentlySearchedItem({
    required this.label,
    required this.onTap, // Make it required to ensure it's always provided
    super.key,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(right: AppWidth.s8),
        padding: EdgeInsets.symmetric(horizontal: AppWidth.s12),
        decoration: BoxDecoration(
          color: ColorManager.lightGrey,
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
              color: ColorManager.secondaryText,
            ),
          ),
        ),
      ),
    );
  }
}