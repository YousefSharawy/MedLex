import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class TermBulletPoint extends StatelessWidget {
  const TermBulletPoint({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: AppHeight.s7),
          width: AppWidth.s6,
          height: AppHeight.s6,
          decoration: BoxDecoration(
            color: ColorManager.darkGrey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppWidth.s12),
        Expanded(
          child: Text(
            text,
            style: getRegularStyle(
              fontSize: FontSize.s12,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.primaryText,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}