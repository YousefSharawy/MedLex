import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // First-time user animations
  late Animation<double> _circleAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _moveUpAnimation;
  late Animation<double> _textSwapAnimation;
  late Animation<double> _buttonAnimation;

  // Returning user animations
  late Animation<double> _returningCircleAnimation;
  late Animation<double> _returningLogoAnimation;

  bool _hasCompletedOnboarding = false;

  @override
  void initState() {
    super.initState();

    _hasCompletedOnboarding = LocalAppStorage.isOnboardingCompleted();

    context.read<SplashCubit>().start();

    if (_hasCompletedOnboarding) {
      // Shorter duration for returning users: circle fill + logo fade
      _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      );

      // Circle fills screen (0 - 700ms)
      _returningCircleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.47, curve: Curves.easeInOut),
        ),
      );

      // Logo fades in (600ms - 1200ms)
      _returningLogoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.40, 0.80, curve: Curves.easeIn),
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted) context.go(Routes.home);
        });
      });
    } else {
      // Full duration for first-time users
      _controller = AnimationController(
        duration: const Duration(milliseconds: 3200),
        vsync: this,
      );

      _circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.17, curve: Curves.easeInOut),
        ),
      );

      _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.11, 0.25, curve: Curves.easeIn),
        ),
      );

      _moveUpAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.34, 0.50, curve: Curves.easeInOut),
        ),
      );

      _textSwapAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.50, 0.69, curve: Curves.easeInOut),
        ),
      );

      _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.72, 0.88, curve: Curves.easeOut),
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.forward();
      });
    }
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
    if (_hasCompletedOnboarding) {
      return _buildReturningSplash();
    }
    return _buildFirstTimeSplash();
  }

  // ─── Returning User Splash ───────────────────────────────────────────────────

  Widget _buildReturningSplash() {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: _returningCircleAnimation.value < 1.0 ? ColorManager.white : null,
            decoration: _returningCircleAnimation.value >= 1.0
                ? BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorManager.splashGradiant1,
                        ColorManager.splashGradiant2,
                      ],
                    ),
                  )
                : null,
            child: Stack(
              children: [
                // Circle fill animation
                if (_returningCircleAnimation.value < 1.0)
                  ClipPath(
                    clipper:
                        CircleRevealClipper(_returningCircleAnimation.value),
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

                // Centered logo fades in after circle fills
                Center(
                  child: Opacity(
                    opacity: _returningLogoAnimation.value,
                    child: Image.asset(IconAssets.logo),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── First-Time User Splash ──────────────────────────────────────────────────

  Widget _buildFirstTimeSplash() {
    double moveUpDistance = AppHeight.s50;
    double slideDistance = 60.0.sp;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: _circleAnimation.value < 1.0 ? ColorManager.white : null,
              gradient: _circleAnimation.value >= 1.0
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
                                      -slideDistance *
                                          _textSwapAnimation.value,
                                      0,
                                    ),
                                    child: Opacity(
                                      opacity: _logoAnimation.value *
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