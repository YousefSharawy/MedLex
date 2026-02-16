import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'By continuing, you agree to our ',
        style: TextStyle(
          fontSize: FontSize.s11,
          color: ColorManager.warmLightGray,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: 'Terms',
            style: getBoldStyle(color: ColorManager.primary),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: getBoldStyle(color: ColorManager.primary),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
