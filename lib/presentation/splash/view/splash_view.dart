import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/app/local_storage.dart';
import 'package:transly/presentation/base/primary_widgets.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/routes.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';
import '../viewModel/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _moveUpAnimation;
  late Animation<double> _textSwapAnimation;
  late Animation<double> _buttonAnimation;

  bool _hasCompletedOnboarding = false;

  @override
  void initState() {
    super.initState();

    // Check onboarding status
    _hasCompletedOnboarding = LocalAppStorage.isOnboardingCompleted();

    context.read<SplashCubit>().start();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    );

    // Circle expansion (0 - 550ms)
    _circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.17, curve: Curves.easeInOut),
      ),
    );

    // Logo + MedLex fade in (350ms - 800ms)
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.11, 0.25, curve: Curves.easeIn),
      ),
    );

    // Move up animation (1100ms - 1600ms)
    _moveUpAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.34, 0.50, curve: Curves.easeInOut),
      ),
    );

    // Text swap animation (1600ms - 2200ms)
    _textSwapAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.50, 0.69, curve: Curves.easeInOut),
      ),
    );

    // Button fade in (2300ms - 2800ms)
    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.72, 0.88, curve: Curves.easeOut),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();

      // If user has completed onboarding, navigate to home after animation
      if (_hasCompletedOnboarding) {
        _navigateToHomeAfterAnimation();
      }
    });
  }

  void _navigateToHomeAfterAnimation() {
    // Navigate to home after the full animation completes (3200ms)
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        context.go(Routes.home);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    context.push(Routes.onboarding1);
  }

  @override
  Widget build(BuildContext context) {
    const double moveUpDistance = 50.0;
    const double slideDistance = 60.0;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: _circleAnimation.value < 1.0 ? Colors.white : null,
              gradient:
                  _circleAnimation.value >= 1.0
                      ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorManager.splashGradiant1,
                          ColorManager.splashGradiant2,
                        ],
                      )
                      : null,
            ),
            child: Stack(
              children: [
                if (_circleAnimation.value < 1.0)
                  ClipPath(
                    clipper: CircleRevealClipper(_circleAnimation.value),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorManager.splashGradiant1,
                            ColorManager.splashGradiant2,
                          ],
                        ),
                      ),
                    ),
                  ),

                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: AppWidth.s48,
                      right: AppWidth.s40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(
                            0,
                            -moveUpDistance * _moveUpAnimation.value,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: AppHeight.s137),
                              FadeTransition(
                                opacity: _logoAnimation,
                                child: Image.asset(IconAssets.logo),
                              ),
                              SizedBox(height: AppHeight.s10),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Transform.translate(
                                    offset: Offset(
                                      -slideDistance * _textSwapAnimation.value,
                                      0,
                                    ),
                                    child: Opacity(
                                      opacity:
                                          _logoAnimation.value *
                                          (1 - _textSwapAnimation.value),
                                      child: Text(
                                        "MedLex",
                                        style: getBoldStyle(
                                          fontSize: FontSize.s42,
                                          fontFamily: FontConstants.interFamily,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(
                                      slideDistance *
                                          (1 - _textSwapAnimation.value),
                                      0,
                                    ),
                                    child: Opacity(
                                      opacity: _textSwapAnimation.value,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Medical knowledge,\nmade visual",
                                            style: getSemiBoldStyle(
                                              fontSize: FontSize.s24,
                                              fontFamily:
                                                  FontConstants.interFamily,
                                              color: ColorManager.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: AppHeight.s20),
                                          Text(
                                            "Understand medical terms through illustrations\nand clear explanations",
                                            style: getRegularStyle(
                                              fontSize: FontSize.s12,
                                              fontFamily:
                                                  FontConstants.interFamily,
                                              color: ColorManager.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppHeight.s120),

                        // Only show button if onboarding is NOT completed
                        if (!_hasCompletedOnboarding)
                          Opacity(
                            opacity: _buttonAnimation.value,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                30 * (1 - _buttonAnimation.value),
                              ),
                              child: PrimaryElevatedButton(
                                title: "Next",
                                height: AppHeight.s46,
                                width: AppWidth.s267,
                                backGroundColor: ColorManager.white,
                                buttonRadius: AppRadius.s16,
                                textStyle: getBoldStyle(
                                  fontSize: FontSize.s14,
                                  fontFamily: FontConstants.interFamily,
                                  color: ColorManager.primary,
                                ),
                                onPress: _onContinuePressed,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double progress;

  CircleRevealClipper(this.progress);

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = sqrt(size.width * size.width + size.height * size.height);
    final radius = maxRadius * progress;

    final path = Path();
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}
