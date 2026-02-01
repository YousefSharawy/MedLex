import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class ModeToggle extends StatelessWidget {
  const ModeToggle({
    super.key,
    required this.isSimpleMode,
    required this.onToggle,
  });

  final bool isSimpleMode;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.s58,
      padding: EdgeInsets.all(AppWidth.s4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(AppRadius.s32),
      ),
      child: Stack(
        children: [_buildSlidingBackground(), _buildToggleButtons()],
      ),
    );
  }

  Widget _buildSlidingBackground() {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: isSimpleMode ? Alignment.centerLeft : Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.s28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      children: [
        _ToggleButton(
          label: 'Simple',
          isActive: isSimpleMode,
          activeColor: ColorManager.primaryText,
          onTap: () => onToggle(true),
        ),
        _ToggleButton(
          label: 'Academic',
          isActive: !isSimpleMode,
          activeColor: ColorManager.primary,
          onTap: () => onToggle(false),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    super.key,
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