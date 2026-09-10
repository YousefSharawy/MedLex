import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/font_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';

class ZoomableIndicator extends StatelessWidget {
  const ZoomableIndicator({
    super.key,
    required this.currentScale,
    required this.onResetZoom,
  });

  final double currentScale;
  final VoidCallback onResetZoom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8.sp,
      right: 8.sp,
      child: GestureDetector(
        onTap: onResetZoom,
        child: AnimatedOpacity(
          opacity: currentScale > 1.05 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppWidth.s10,
              vertical: AppHeight.s6,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppRadius.s20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${currentScale.toStringAsFixed(1)}x',
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: AppWidth.s4),
                Icon(Icons.close, color: Colors.white, size: 14.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
