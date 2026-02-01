import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';

class ZoomImageCard extends StatelessWidget {
  const ZoomImageCard({
    super.key,
    required this.currentScale,
    required this.onResetZoom,
    required this.child,
  });

  final double currentScale;
  final VoidCallback onResetZoom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppWidth.s20),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.s16),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(63),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          child,
          if (currentScale > 1.05)
            ZoomableIndicator(
              currentScale: currentScale,
              onResetZoom: onResetZoom,
            ),
        ],
      ),
    );
  }
}

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
              color: Colors.black.withOpacity(0.6),
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

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.s155,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.tealSoft.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppRadius.s12),
      ),
      child: Icon(
        Icons.medical_information_outlined,
        size: 60.sp,
        color: ColorManager.secondaryText.withOpacity(0.5),
      ),
    );
  }
}