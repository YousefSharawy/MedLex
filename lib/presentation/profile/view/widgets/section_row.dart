import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class SectionRow extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  final double? iconWidth;
  final double? iconHeight;
  final Color? iconColor;

  const SectionRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconWidth ,
    this.iconHeight,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            icon,
            width: iconWidth ?? AppWidth.s20,
            height: iconHeight ?? AppHeight.s20,
            color: iconColor ?? ColorManager.grayIcon,
          ),
          SizedBox(width: AppWidth.s12),
          Expanded(
            child: Text(
              label,
              style: getRegularStyle(
                fontSize: FontSize.s15,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.primaryText,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: ColorManager.chevronRight,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}
