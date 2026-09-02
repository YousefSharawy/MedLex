import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/app/resources/values_manager.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_details_app_bar.dart';
import 'package:medlex/presentation/termDetails/view/widgets/term_details_body.dart';
import 'package:medlex/presentation/base/primary_teal_scaffold.dart';

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

  @override
  Widget build(BuildContext context) {
    return PrimaryTealScaffold(
      body: SafeArea(
        child: Column(
          children: [
            TermDetailsAppBar(term: widget.term),
            SizedBox(height: AppHeight.s22),
            Expanded(
              child: TermDetailsBody(
                term: widget.term,
                isSimpleMode: _isSimpleMode,
                currentScale: _currentScale,
                transformController: _transformController,
                zoomAnimationController: _zoomAnimationController,
                onDoubleTapDown: _handleDoubleTap,
                onResetZoom: _resetZoom,
                onModeToggle: (value) => setState(() => _isSimpleMode = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
