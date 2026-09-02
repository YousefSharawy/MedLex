import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/app/resources/assets_manager.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class GoogleSignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const GoogleSignInButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppHeight.s48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: ColorManager.tealSoft, width: 1.5.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.s14),
          ),
          backgroundColor: ColorManager.white,
          elevation: 0,
        ),
        child: isLoading
            ?  SizedBox(
                width: AppWidth.s22,
                height: AppHeight.s22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5.sp,
                  color: ColorManager.tealSoft,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconAssets.google,
                    width: AppWidth.s20,
                    height: AppHeight.s20,
                    errorBuilder: (_, __, ___) =>  Icon(
                      Icons.g_mobiledata_rounded,
                      size: 24.sp,
                      color: ColorManager.primaryText,
                    ),
                  ),
                   SizedBox(width: AppWidth.s12),
                   Text(
                    'Continue with Google',
                    style: getBoldStyle(
                      fontSize: FontSize.s16
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}