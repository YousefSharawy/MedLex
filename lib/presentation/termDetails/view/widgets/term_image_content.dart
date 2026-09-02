import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/app/ui_utils.dart';

class TermImageContent extends StatelessWidget {
  final String? imageUrl;
  final TransformationController transformController;
  final AnimationController zoomAnimationController;

  const TermImageContent({
    super.key,
    required this.imageUrl,
    required this.transformController,
    required this.zoomAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return UiUtils.zoomCardNoImagePlaceholder();
    }

    return InteractiveViewer(
      transformationController: transformController,
      minScale: 0.8.sp,
      maxScale: 5.0.sp,
      onInteractionStart: (details) {
        if (zoomAnimationController.isAnimating) {
          zoomAnimationController.stop();
        }
      },
      child: Image.network(
        imageUrl!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => UiUtils.zoomCardNoImagePlaceholder(),
      ),
    );
  }
}
