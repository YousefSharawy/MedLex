import 'package:flutter/material.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';

/// Centered hint below the image card.
/// Shows a static "pinch to zoom" label at 1×, and switches to a live
/// scale readout once the user has zoomed in.
class ZoomHintText extends StatelessWidget {
  const ZoomHintText({super.key, required this.currentScale});

  final double currentScale;

  @override
  Widget build(BuildContext context) {
    final isZoomed = currentScale > 1.05;

    return Align(
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          isZoomed
              ? 'Double-tap to reset • ${currentScale.toStringAsFixed(1)}x zoom'
              : 'Medical illustration • Pinch or double-tap to zoom',
          key: ValueKey(isZoomed),
          style: getRegularStyle(
            fontSize: FontSize.s12,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.graySecondaryText,
          ),
        ),
      ),
    );
  }
}