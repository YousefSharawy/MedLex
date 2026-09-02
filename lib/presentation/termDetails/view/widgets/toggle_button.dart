import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/style_manager.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({super.key, 
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: getMediumStyle(
              fontSize: FontSize.s14,
              fontFamily: FontConstants.interFamily,
              color: isActive ? activeColor : ColorManager.secondaryText,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
