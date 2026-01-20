import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/resources/color_manager.dart';
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

  @override
  void initState() {
    context.read<SplashCubit>().start();
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Circle expansion animation (0 to 1000ms)
    _circleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
    ));

    // Logo fade-in animation (800ms to 1500ms)
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    ));

    // Start animation when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        state.when(initial: () {}, success: (view) => context.go(view));
      },
      child: Scaffold(
        body: Stack(
          children: [
            // White background
            Container(color: Colors.white),
            
            // Animated circular green fill
         AnimatedBuilder(
  animation: _circleAnimation,
  builder: (context, child) {
    return ClipPath(
      clipper: CircleRevealClipper(_circleAnimation.value),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorManager.splashGradiant1,
              ColorManager.splashGradiant2, // Lighter shade
              // OR use a different color:
              // Color(0xFF4CAF50), // Replace with your second color
            ],
          ),
        ),
      ),
    );
  },
),
            // Logo with fade-in animation
            Center(
              child: FadeTransition(
                opacity: _logoAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(IconAssets.logo),
                    SizedBox(height: AppHeight.s15,),
                    Text("MedLex",style: getBoldStyle(
                      fontSize: FontSize.s42,
                      fontFamily: FontConstants.interFamily,
                      color: ColorManager.white
                    ),)
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

class CircleRevealClipper extends CustomClipper<Path> {
  final double progress;

  CircleRevealClipper(this.progress);

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Calculate the maximum radius needed to cover entire screen
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