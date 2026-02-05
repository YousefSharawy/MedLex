import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class LetterHeader extends StatelessWidget {
  final String letter;

  const LetterHeader({
    super.key,
    required this.letter,
  });

  static final _style = getBoldStyle(
    fontSize: FontSize.s20,
    fontFamily: FontConstants.interFamily,
    color: ColorManager.primaryText,
  );

  static final _padding = EdgeInsets.only(
    top: AppHeight.s12,
    bottom: AppHeight.s6,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: Text(
        letter == '#' ? 'Prefixes/Suffixes' : letter,
        style: _style,
      ),
    );
  }
}
