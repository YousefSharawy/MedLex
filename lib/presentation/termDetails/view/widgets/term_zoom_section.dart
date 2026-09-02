import 'package:flutter/material.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_image_content.dart';
import 'package:medlex/presentation/termDetails/view/widgets/zoom_hint_text.dart';
import 'package:medlex/presentation/termDetails/view/widgets/zoom_image_card.dart';
import 'package:medlex/app/resources/values_manager.dart';

class TermZoomSection extends StatelessWidget {
  final String? imageUrl;
  final double currentScale;
  final TransformationController transformController;
  final AnimationController zoomAnimationController;
  final GestureTapDownCallback onDoubleTapDown;
  final VoidCallback onResetZoom;

  const TermZoomSection({
    super.key,
    required this.imageUrl,
    required this.currentScale,
    required this.transformController,
    required this.zoomAnimationController,
    required this.onDoubleTapDown,
    required this.onResetZoom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onDoubleTapDown: onDoubleTapDown,
          child: ZoomImageCard(
            currentScale: currentScale,
            onResetZoom: onResetZoom,
            child: TermImageContent(
              imageUrl: imageUrl,
              transformController: transformController,
              zoomAnimationController: zoomAnimationController,
            ),
          ),
        ),
        SizedBox(height: AppHeight.s4),
        ZoomHintText(currentScale: currentScale),
      ],
    );
  }
}
