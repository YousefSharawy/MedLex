import 'package:flutter/material.dart';
import 'package:medlex/app/resources/color_manager.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'zoomable_indicator.dart';

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
