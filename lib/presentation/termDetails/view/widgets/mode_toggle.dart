import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'toggle_button.dart';

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
                color: Colors.black.withValues(alpha: 0.05),
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
        ToggleButton(
          label: 'Simple',
          isActive: isSimpleMode,
          activeColor: ColorManager.primaryText,
          onTap: () => onToggle(true),
        ),
        ToggleButton(
          label: 'Academic',
          isActive: !isSimpleMode,
          activeColor: ColorManager.primaryTeal,
          onTap: () => onToggle(false),
        ),
      ],
    );
  }
}
