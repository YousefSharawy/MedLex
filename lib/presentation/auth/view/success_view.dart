import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class SuccessView extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback onStartLearning;

  const SuccessView({
    super.key,
    required this.controller,
    required this.onStartLearning,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('success'),
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppHeight.s32),
          // Animated Check
          ScaleTransition(
            scale: CurvedAnimation(
              parent: controller,
              curve: Curves.elasticOut,
            ),
            child: Container(
              width: AppWidth.s72,
              height: AppHeight.s72,
              decoration: BoxDecoration(
                color: ColorManager.tealSoft,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 36.sp,
                color: ColorManager.primaryTeal,
              ),
            ),
          ),
          SizedBox(height: AppHeight.s20),

          Text(
            "You're all set!",
            style: getBoldStyle(
              fontSize: FontSize.s22,
              color: ColorManager.primaryText,
            ).copyWith(letterSpacing: -0.3.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppHeight.s8),
          Text(
            'Your account is ready. Start exploring\nmedical terms and building your study list.',
            style: getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.secondaryText,
            ).copyWith(height: 1.5.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppHeight.s28),

          SizedBox(
            width: double.infinity,
            height: AppHeight.s54,
            child: ElevatedButton(
              onPressed: onStartLearning,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryTeal,
                foregroundColor: ColorManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.s14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Start Learning',
                style: getBoldStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.white,
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppHeight.s24),
        ],
      ),
    );
  }
}