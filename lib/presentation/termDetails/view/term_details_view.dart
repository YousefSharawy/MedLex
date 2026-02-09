import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/app/ui_utiles.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/termDetails/view/widgets/mode_toggle.dart';
import 'package:transly/presentation/termDetails/view/widgets/term_content_sections.dart';
import 'package:transly/presentation/termDetails/view/widgets/term_details_app_bar.dart';
import 'package:transly/presentation/termDetails/view/widgets/term_title_row.dart';
import 'package:transly/presentation/termDetails/view/widgets/zoom_hint_text.dart';
import 'package:transly/presentation/termDetails/view/widgets/zoom_image_card.dart';

class TermDetailsView extends StatefulWidget {
  final TermModel term;
  const TermDetailsView({super.key, required this.term});

  @override
  State<TermDetailsView> createState() => _TermDetailsViewState();
}

class _TermDetailsViewState extends State<TermDetailsView>
    with SingleTickerProviderStateMixin {
 
  bool _isSimpleMode = true;

  double _currentScale = 1.0;

  final TransformationController _transformController =
      TransformationController();
  late AnimationController _zoomAnimationController;
  Animation<Matrix4>? _zoomAnimation;

  @override
  void initState() {
    super.initState();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _transformController.addListener(_onTransformChanged);
  }

  @override
  void dispose() {
    _transformController.removeListener(_onTransformChanged);
    _transformController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }

  void _onTransformChanged() {
    final scale = _transformController.value.getMaxScaleOnAxis();
    if (scale != _currentScale) {
      setState(() => _currentScale = scale);
    }
  }

  void _handleDoubleTap(TapDownDetails details) {
    final position = details.localPosition;
    final targetScale = 2.5.sp;
    final translateMultiplier = 1.5.sp;
    
    final Matrix4 endMatrix =
        _transformController.value != Matrix4.identity()
              ? Matrix4.identity()
              : Matrix4.identity()
          ..translate(-position.dx * translateMultiplier, -position.dy * translateMultiplier)
          ..scale(targetScale);

    _animateZoom(endMatrix);
  }

  void _animateZoom(Matrix4 endMatrix) {
    _zoomAnimation = Matrix4Tween(
      begin: _transformController.value,
      end: endMatrix,
    ).animate(
      CurvedAnimation(
        parent: _zoomAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _zoomAnimation!.addListener(() {
      _transformController.value = _zoomAnimation!.value;
    });

    _zoomAnimationController.forward(from: 0);
  }

  void _resetZoom() {
    _animateZoom(Matrix4.identity());
  }

  Widget _buildImageContent() {
    final imageUrl = widget.term.imageUrl;

    if (imageUrl == null || imageUrl.isEmpty) {
      return UiUtils.zoomCardNoImagePlaceholder();
    }

    return InteractiveViewer(
      transformationController: _transformController,
      minScale: 0.8.sp,
      maxScale: 5.0.sp,
      onInteractionStart: (details) {
        if (_zoomAnimationController.isAnimating) {
          _zoomAnimationController.stop();
        }
      },
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => UiUtils.zoomCardNoImagePlaceholder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: Column(
          children: [
            TermDetailsAppBar(term: widget.term),
            SizedBox(height: AppHeight.s22),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onDoubleTapDown: _handleDoubleTap,
                      child: ZoomImageCard(
                        currentScale: _currentScale,
                        onResetZoom: _resetZoom,
                        child: _buildImageContent(),
                      ),
                    ),
                    SizedBox(height: AppHeight.s4),
                    ZoomHintText(currentScale: _currentScale),
                    SizedBox(height: AppHeight.s19),
                    TermTitleRow(term: widget.term),
                    SizedBox(height: AppHeight.s15),
                    ModeToggle(
                      isSimpleMode: _isSimpleMode,
                      onToggle:
                          (value) => setState(() => _isSimpleMode = value),
                    ),
                    SizedBox(height: AppHeight.s15),
                    TermContentSections(
                      term: widget.term,
                      isSimpleMode: _isSimpleMode,
                    ),
                    SizedBox(height: AppHeight.s80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}