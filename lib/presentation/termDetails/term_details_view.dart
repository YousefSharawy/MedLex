import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/resources/assets_manager.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/termDetails/term_bullet_point.dart';
import 'package:transly/presentation/termDetails/term_section_header.dart';

class TermDetailsView extends StatefulWidget {
  const TermDetailsView({super.key});

  @override
  State<TermDetailsView> createState() => _TermDetailsViewState();
}

class _TermDetailsViewState extends State<TermDetailsView>
    with SingleTickerProviderStateMixin {
  bool _isSimpleMode = true;

  // Zoom controllers
  final TransformationController _transformController =
      TransformationController();
  late AnimationController _zoomAnimationController;
  Animation<Matrix4>? _zoomAnimation;

  // Track current zoom level
  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Listen to transformation changes to track scale
    _transformController.addListener(_onTransformChanged);
  }

  void _onTransformChanged() {
    final scale = _transformController.value.getMaxScaleOnAxis();
    if (scale != _currentScale) {
      setState(() => _currentScale = scale);
    }
  }

  void _handleDoubleTap(TapDownDetails details) {
    final position = details.localPosition;

    Matrix4 endMatrix;

    if (_transformController.value != Matrix4.identity()) {
      // Zoom out to original
      endMatrix = Matrix4.identity();
    } else {
      // Zoom in to 2.5x at tap position
      endMatrix =
          Matrix4.identity()
            ..translate(-position.dx * 1.5, -position.dy * 1.5)
            ..scale(2.5);
    }

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
  void dispose() {
    _transformController.removeListener(_onTransformChanged);
    _transformController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black87,
                      size: 24.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(IconAssets.bookmark),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppHeight.s22),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Zoomable Image Card
                    _buildZoomableImageCard(),

                    SizedBox(height: AppHeight.s4),

                    // Zoom hint text
                    _buildZoomHintText(),

                    SizedBox(height: AppHeight.s19),

                    // Title row
                    _buildTitleRow(),

                    SizedBox(height: AppHeight.s4),

                    // Pronunciation
                    Text(
                      '/ˌmaɪ.oʊˈkɑːr.di.əm/',
                      style: getRegularStyle(
                        fontSize: FontSize.s14,
                        fontFamily: FontConstants.interFamily,
                        color: ColorManager.secondaryText,
                      ),
                    ),

                    SizedBox(height: AppHeight.s15),

                    // Toggle Simple/Academic
                    _buildModeToggle(),

                    SizedBox(height: AppHeight.s15),

                    // Animated content sections
                    _buildContentSections(),

                    SizedBox(height: AppHeight.s100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomableImageCard() {
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
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Zoomable Image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.s12),
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTap,
              onDoubleTap: () {}, // Required for onDoubleTapDown to work
              child: InteractiveViewer(
                transformationController: _transformController,
                minScale: 1.0,
                maxScale: 4.0,
                boundaryMargin: const EdgeInsets.all(20),
                panEnabled: true,
                scaleEnabled: true,
                clipBehavior: Clip.hardEdge,
                onInteractionEnd: (details) {
                  // Optional: Reset if scale is very close to 1
                  if (_currentScale < 1.05) {
                    _resetZoom();
                  }
                },
                child: Image.asset(
                  ImageAssets.heart,
                  height: AppHeight.s155,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Zoom indicator (shows when zoomed)
          if (_currentScale > 1.05)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: _resetZoom,
                child: AnimatedOpacity(
                  opacity: _currentScale > 1.05 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_currentScale.toStringAsFixed(1)}x',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.close, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildZoomHintText() {
    return Align(
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          _currentScale > 1.05
              ? 'Double-tap to reset • ${_currentScale.toStringAsFixed(1)}x zoom'
              : 'Medical illustration • Pinch or double-tap to zoom',
          key: ValueKey(_currentScale > 1.05),
          style: getRegularStyle(
            fontSize: FontSize.s12,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.graySecondaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Myocardium',
          style: getSemiBoldStyle(
            fontSize: FontSize.s16,
            fontFamily: FontConstants.interFamily,
            color: ColorManager.primaryText,
          ),
        ),
        SizedBox(width: AppWidth.s16),
        GestureDetector(onTap: () {}, child: Image.asset(IconAssets.volumeUp)),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.s10,
            vertical: AppHeight.s7,
          ),
          decoration: BoxDecoration(
            color: ColorManager.tealSoft,
            borderRadius: BorderRadius.circular(AppRadius.s32),
          ),
          child: Text(
            'Cardiology',
            style: getRegularStyle(
              fontSize: FontSize.s12,
              fontFamily: FontConstants.interFamily,
              color: ColorManager.primaryText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModeToggle() {
    return Container(
      height: AppHeight.s58,
      padding: EdgeInsets.all(AppWidth.s4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(AppRadius.s32),
      ),
      child: Stack(
        children: [
          // Animated sliding background
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment:
                _isSimpleMode ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.s28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isSimpleMode = true),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: getMediumStyle(
                        fontSize: FontSize.s14,
                        fontFamily: FontConstants.interFamily,
                        color:
                            _isSimpleMode
                                ? ColorManager.primaryText
                                : ColorManager.secondaryText,
                      ),
                      child: const Text('Simple'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isSimpleMode = false),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: getMediumStyle(
                        fontSize: FontSize.s14,
                        fontFamily: FontConstants.interFamily,
                        color:
                            !_isSimpleMode
                                ? ColorManager.primary
                                : ColorManager.secondaryText,
                      ),
                      child: const Text('Academic'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentSections() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Column(
        key: ValueKey(_isSimpleMode),
        children: [
          // Definition
          TermSectionHeader(
            title: 'Definition',
            child: Text(
              _isSimpleMode
                  ? 'Commonly known as a heart attack. Occurs when blood flow to part of the heart muscle is blocked.'
                  : 'Acute coronary syndrome resulting from myocardial necrosis secondary to prolonged ischemia, typically caused by thrombotic occlusion of a coronary artery due to atherosclerotic plaque rupture. Diagnosed via elevated cardiac biomarkers (troponin) and ECG changes.',
              style: getRegularStyle(
                fontSize: FontSize.s14,
                fontFamily: FontConstants.interFamily,
                color: ColorManager.darkGrey,
                height: 1.4,
              ),
            ),
          ),

          SizedBox(height: AppHeight.s16),

          // Causes
          TermSectionHeader(
            title: 'Causes',
            child: Column(
              children: const [
                TermBulletPoint(text: 'Coronary artery atherosclerosis'),
                TermBulletPoint(text: 'Plaque rupture with thrombosis'),
                TermBulletPoint(text: 'Coronary artery spasm'),
                TermBulletPoint(text: 'Cocaine use'),
                TermBulletPoint(text: 'Coronary embolism'),
              ],
            ),
          ),

          SizedBox(height: AppHeight.s16),

          // Symptoms
          TermSectionHeader(
            title: 'Symptoms',
            child: Column(
              children: const [
                TermBulletPoint(text: 'Chest pain or pressure'),
                TermBulletPoint(text: 'Shortness of breath'),
                TermBulletPoint(text: 'Pain radiating to arm, jaw, or back'),
                TermBulletPoint(text: 'Nausea and sweating'),
                TermBulletPoint(text: 'Lightheadedness'),
              ],
            ),
          ),

          SizedBox(height: AppHeight.s16),

          // Treatment
          TermSectionHeader(
            title: 'Treatment',
            child: Column(
              children: const [
                TermBulletPoint(text: 'Aspirin and antiplatelet therapy'),
                TermBulletPoint(
                  text: 'Percutaneous coronary intervention (PCI)',
                ),
                TermBulletPoint(text: 'Thrombolytic therapy'),
                TermBulletPoint(text: 'Beta-blockers'),
                TermBulletPoint(text: 'ACE inhibitors'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
