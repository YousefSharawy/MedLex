import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class PlaceHolderItem extends StatelessWidget {
  const PlaceHolderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppHeight.s12),
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.s10,
        vertical: AppHeight.s7,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(color: ColorManager.black.withAlpha(25)),
        borderRadius: BorderRadius.circular(AppRadius.s16),
      ),
      child: Row(
        children: [
          Container(
            width: AppWidth.s59,
            height: AppHeight.s66,
            decoration: BoxDecoration(
              color: ColorManager.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppRadius.s8),
            ),
          ),
          SizedBox(width: AppWidth.s15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No recent terms',
                  style: getRegularStyle(
                    fontSize: FontSize.s15,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.secondaryText,
                  ),
                ),
                SizedBox(height: AppHeight.s8),
                Text(
                  'Search to add terms',
                  style: getRegularStyle(
                    fontSize: FontSize.s12,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.secondaryText.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
