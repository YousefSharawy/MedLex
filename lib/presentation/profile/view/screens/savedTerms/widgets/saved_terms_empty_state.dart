import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/routes.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/base/primary_elevated_button.dart';

class SavedTermsEmptyState extends StatelessWidget {
  const SavedTermsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s32),
      child: Column(
        children: [
          SizedBox(height: AppHeight.s158),
          Container(
            width: AppWidth.s68,
            height: AppHeight.s68,
            decoration: BoxDecoration(
              color: ColorManager.tealSoft,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                IconAssets.bookmark,
                width: 24.sp,
                height: 24.sp,
                color: ColorManager.primaryTeal,
              ),
            ),
          ),
          SizedBox(height: AppHeight.s43),
          Text(
            'No saved terms yet',
            style: getBoldStyle(
              fontSize: FontSize.s24,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.primaryText,
            ),
          ),
          SizedBox(height: AppHeight.s10),
          Text(
            'Bookmark terms to build your personal study list',
            textAlign: TextAlign.center,
            style: getRegularStyle(
              fontSize: FontSize.s15,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.secondaryText,
            ),
          ),
          SizedBox(height: AppHeight.s32),
          PrimaryElevatedButton(
            title: "Browse Dictionary",
            onPress: () {
              context.pop();
              context.go(Routes.dictionary);
            },
            width: AppWidth.s163,
            height: AppHeight.s48,
            buttonRadius: AppRadius.s16,
            textStyle: getBoldStyle(
              fontSize: FontSize.s12,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }
}
