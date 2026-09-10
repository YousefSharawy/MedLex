import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';

class AzIndexBarConfig extends IndexBarOptions {
  AzIndexBarConfig()
      : super(
          hapticFeedback: true,
          needRebuild: true,
          indexHintAlignment: Alignment.centerRight,
          indexHintOffset: const Offset(-20, 0),
          selectItemDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorManager.primaryTeal.withValues(alpha: 0.3),
          ),
          textStyle: getRegularStyle(
            fontSize: FontSize.s9,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primaryTeal,
          ),
          selectTextStyle: getBoldStyle(
            fontSize: FontSize.s11,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primaryTeal,
          ),
        );
}