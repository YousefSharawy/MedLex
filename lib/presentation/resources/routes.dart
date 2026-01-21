
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/onboarding/on_boarding_second_view.dart';
import 'package:transly/presentation/onboarding/on_boarding_view.dart';

import '../splash/view/splash_view.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2 = '/onboarding2';
  
}

class AppNavigation {
  AppNavigation._();
  static final _rootNK = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    navigatorKey: _rootNK,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.splash,
        pageBuilder:
            (context, state) => CustomTransitionPage2(
              key: state.pageKey,
              child: const SplashView(),
            ),
      ),
      GoRoute(
        path: Routes.onboarding1,
        pageBuilder:
            (context, state) => CustomTransitionPage2(
              key: state.pageKey,
              child: const OnBoardingView(),
            ),
      ),
      GoRoute(
        path: Routes.onboarding2,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const OnBoardingSecondView(),
            ),
      ),
      // GoRoute(
      //   path: Routes.home,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const HomeView(),
      //       ),
      // ),
      // GoRoute(
      //   path: Routes.translation,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const TranslationView(),
      //       ),
      // ),
      
      // GoRoute(
      //   path: Routes.translationHistory,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const TrasnslationHistoryView(),
      //       ),
      // ),
      // GoRoute(
      //   path: Routes.textTranslation,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const TextTranslationView(),
      //       ),
      // ),
      // GoRoute(
      //   path: Routes.videoTranslation,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const VideoTranslationView(),
      //       ),
      // ),
      // GoRoute(
      //   path: Routes.audioTranslation,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const AudioTranslationView(),
      //       ),
      // ),
      // GoRoute(
      //   path: Routes.translationResult,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const TranslationResultView(),
      //       ),
      // ),
      
      // GoRoute(
      //   path: Routes.profile,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const ProfileView(),
      //       ),
      // ),
      // GoRoute(
      //   path: Routes.subscription,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const SubscriptionPlanView(),
      //       ),
      // ),
      
      // ShellRoute(
      //   parentNavigatorKey: _rootNK,
      //   builder: (context, state, child) {
      //     return BlocProvider(
      //       create: (context) => AuthBloc(getIt<Repository>()),
      //       child: child,
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: Routes.login,
      //       pageBuilder:
      //           (context, state) => CustomTransitionPage(
      //             key: state.pageKey,
      //             child: const LoginView(),
      //           ),
      //     ),
      //     GoRoute(
      //       path: Routes.loginInfo,
      //       pageBuilder:
      //           (context, state) => CustomTransitionPage(
      //             key: state.pageKey,
      //             child: const LoginInfoView(),
      //           ),
      //     ),
      //   ],
      // ),
    ],
  );
}

class CustomTransitionPage extends Page {
  final Widget child;

  const CustomTransitionPage({required LocalKey key, required this.child})
    : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    const curve = Curves.easeOutSine;

    return MaterialPageRoute(
      settings: this,
      builder: (context) {
        final route = ModalRoute.of(context)!;
        final animation = route.animation!;

        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
          reverseCurve: curve.flipped,
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: curve,
            reverseCurve: curve.flipped,
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(opacity: fadeAnimation, child: child),
        );
      },
      fullscreenDialog: false,
    );
  }
}

/// Custom transition with cross-fade masked by a diagonal light sweep.
/// The light travels from primary button area (bottom-right) to back button (top-left)
/// and back, creating continuity illusion rather than navigation feel.
class CustomTransitionPage2 extends Page {
  final Widget child;
  final Duration duration;

  const CustomTransitionPage2({
    required LocalKey key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }
}