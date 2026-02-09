import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class IndexHintBubble extends StatelessWidget {
  final String hint;
  final void Function(String) onSelected;

  const IndexHintBubble({
    super.key,
    required this.hint,
    required this.onSelected,
  });

  static final _decoration = BoxDecoration(
    color: ColorManager.primary,
    shape: BoxShape.circle,
  );

  static final _textStyle = getBoldStyle(
    fontSize: FontSize.s24,
    fontFamily: FontConstants.interFamily,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSelected(hint);
    });

    return Container(
      width: AppWidth.s50,
      height: AppHeight.s50,
      decoration: _decoration,
      alignment: Alignment.center,
      child: Text(hint, style: _textStyle),
    );
  }
}