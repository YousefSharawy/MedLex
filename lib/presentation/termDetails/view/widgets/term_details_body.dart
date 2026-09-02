import 'package:flutter/material.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/presentation/termDetails/view/widgets/mode_toggle.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_content_sections.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_title_row.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_zoom_section.dart';
import 'package:medlex/app/resources/values_manager.dart';

class TermDetailsBody extends StatelessWidget {
  final TermModel term;
  final bool isSimpleMode;
  final double currentScale;
  final TransformationController transformController;
  final AnimationController zoomAnimationController;
  final GestureTapDownCallback onDoubleTapDown;
  final VoidCallback onResetZoom;
  final ValueChanged<bool> onModeToggle;

  const TermDetailsBody({
    super.key,
    required this.term,
    required this.isSimpleMode,
    required this.currentScale,
    required this.transformController,
    required this.zoomAnimationController,
    required this.onDoubleTapDown,
    required this.onResetZoom,
    required this.onModeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TermZoomSection(
            imageUrl: term.imageUrl,
            currentScale: currentScale,
            transformController: transformController,
            zoomAnimationController: zoomAnimationController,
            onDoubleTapDown: onDoubleTapDown,
            onResetZoom: onResetZoom,
          ),
          SizedBox(height: AppHeight.s19),
          TermTitleRow(term: term),
          SizedBox(height: AppHeight.s15),
          ModeToggle(
            isSimpleMode: isSimpleMode,
            onToggle: onModeToggle,
          ),
          SizedBox(height: AppHeight.s15),
          TermContentSections(
            term: term,
            isSimpleMode: isSimpleMode,
          ),
          SizedBox(height: AppHeight.s80),
        ],
      ),
    );
  }
}
