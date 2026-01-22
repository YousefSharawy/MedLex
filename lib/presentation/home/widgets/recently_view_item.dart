import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class RecentlyViewedItem extends StatelessWidget {
  final String title;
  final String category;

  const RecentlyViewedItem({super.key, required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: AppWidth.s10,vertical: AppHeight.s7),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(
          color: ColorManager.black.withAlpha(25),
        ),
        borderRadius: BorderRadius.circular(AppRadius.s16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppWidth.s59,
            height: AppHeight.s66,
            child: Image.asset(ImageAssets.heart, fit: BoxFit.cover),
          ),
           SizedBox(width: AppWidth.s15),

          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical:AppHeight.s3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getRegularStyle(
                      fontSize: FontSize.s15,
                      fontFamily: FontConstants.interFamily,
                      color: ColorManager.primaryText,
                    ),
                  ),
                   SizedBox(height:AppHeight.s8),
                  Text(
                    category,
                    style: getRegularStyle(
                      fontSize: FontSize.s12,
                      fontFamily: FontConstants.interFamily,
                      color: ColorManager.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(IconAssets.bookmark)
          
        ],
      ),
    );
  }
}