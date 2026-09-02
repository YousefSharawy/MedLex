import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/resources/color_manager.dart';
import '../../app/resources/values_manager.dart';

class PrimaryElevatedButton extends StatelessWidget {
  const PrimaryElevatedButton({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.onPress,
    this.backGroundColor,
    this.titleWidget,
    this.isLoading = false,
    this.groub,
    this.value,
    this.iconPath,
    this.buttonRadius,
    required this.textStyle,
    this.borderColor,
  });
  final String title;
  final double? height;
  final double? width;
  final VoidCallback onPress;
  final Color? backGroundColor;
  final Widget? titleWidget;
  final bool isLoading;
  final dynamic groub;
  final dynamic value;
  final String? iconPath;
  final Color? borderColor;

  final TextStyle textStyle;
  final double? buttonRadius;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          
          backgroundColor: backGroundColor ?? ColorManager.primaryTeal,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? ColorManager.trasnparent),
            borderRadius: BorderRadius.circular(buttonRadius ?? AppRadius.s20),
          ),
          fixedSize: Size(width ?? 1.sw, height ?? AppHeight.s48),
        ),
        onPressed: onPress,
        child:
            // isLoading
            //     ? LoadingAnimationWidget.staggeredDotsWave(
            //         color: ColorManager.white,
            //         size: AppWidth.s40,
            //       )
            //     :
            titleWidget ??
            FittedBox(
              child: Row(
                children: [
                  if (iconPath != null) ...[
                    Image.asset(
                      iconPath!,
                      width: AppWidth.s16,
                      height: AppHeight.s16,
                      color: ColorManager.white,
                    ),
                  ],
                  SizedBox(width: AppWidth.s8,),
                  Center(child: Text(title, style: textStyle)),
                ],
              ),
            ),
      ),
    );
  }
}
