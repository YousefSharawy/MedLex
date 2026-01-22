import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class DailyTermCard extends StatelessWidget {
  const DailyTermCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.only(top: AppHeight.s9,bottom: AppHeight.s15),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.s16),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(63),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: AppWidth.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                ImageAssets.heart, // Replace with your asset
                height: AppHeight.s144,
                fit: BoxFit.contain,
              ),
            ),
             SizedBox(height: AppHeight.s14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Myocardium',
                  style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.primaryText,
                  ),
                ),
                Container(
                  padding:  EdgeInsets.symmetric(
                    horizontal: AppHeight.s10,
                    vertical: AppWidth.s7,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.tealSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Cardiology',
                    style: getRegularStyle(
                      fontSize: FontSize.s12,
                      fontFamily: FontConstants.interFamily,
                      color: ColorManager.primaryText,
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: AppHeight.s8),   
            Row(
              children: [
                Text(
                  '/ˌmar.di.əm/',
                  style: getRegularStyle(
                    fontSize: FontSize.s12,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.secondaryText,
                  ),
                ),
                 SizedBox(width:AppWidth.s9),
                GestureDetector(
                  onTap: () {
                  },
                  child: Image.asset(IconAssets.volumeUp)
                ),
              ],
            ),
             SizedBox(height:AppHeight.s8),
        
            // Description
            Text(
              'The muscular tissue of the heart.',
              style: getRegularStyle(
                fontSize: FontSize.s12,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
