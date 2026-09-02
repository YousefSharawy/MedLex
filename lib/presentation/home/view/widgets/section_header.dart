// Section Header Widget
import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class SectionHeader extends StatelessWidget {
  final String iconPath;
  final String title;

   const SectionHeader({super.key, 
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath),
         SizedBox(width: AppWidth.s3),
        Text(
          title,
          style: getRegularStyle(
            fontSize: FontSize.s15,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primaryText,
          ),
        ),
      ],
    );
  }
}