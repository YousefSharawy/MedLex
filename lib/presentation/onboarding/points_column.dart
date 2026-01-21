import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class PointsColumn extends StatelessWidget {
  const PointsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppWidth.s33),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(IconAssets.splashCorrectIcon),
              SizedBox(width: AppWidth.s12),
              Text(
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.white,
                  fontFamily: FontConstants.interFamily,
                ),
                "Visual explanations for medical terms",
              ),
            ],
          ),
          SizedBox(height: AppHeight.s8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(IconAssets.splashCorrectIcon),
              SizedBox(width: AppWidth.s12),
              Text(
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.white,
                  fontFamily: FontConstants.interFamily,
                ),
                "Clinical cases to apply knowledge",
              ),
            ],
          ),
          SizedBox(height: AppHeight.s8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(IconAssets.splashCorrectIcon),
              SizedBox(width: AppWidth.s12),
              Text(
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.white,
                  fontFamily: FontConstants.interFamily,
                ),
                "Save and review important terms",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
