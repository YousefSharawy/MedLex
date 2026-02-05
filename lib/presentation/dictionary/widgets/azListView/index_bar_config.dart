import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';

class AzIndexBarConfig extends IndexBarOptions {
  AzIndexBarConfig()
      : super(
          hapticFeedback: true,
          needRebuild: true,
          indexHintAlignment: Alignment.centerRight,
          indexHintOffset: const Offset(-20, 0),
          selectItemDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorManager.primary.withOpacity(0.3),
          ),
          textStyle: getRegularStyle(
            fontSize: FontSize.s9,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primary,
          ),
          selectTextStyle: getBoldStyle(
            fontSize: FontSize.s11,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primary,
          ),
        );
}