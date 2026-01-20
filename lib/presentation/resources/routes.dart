
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transly/presentation/onboarding/on_boarding_view.dart';

import '../splash/view/splash_view.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String translation = '/translation';
  static const String subscription = '/subscription';
  static const String audioTranslation = '/audiotranslation';
  static const String videoTranslation = '/videotranslation';
  static const String textTranslation = '/texttranslation';
  static const String translationHistory = '/translationhistory';
  static const String translationResult = '/translationresult';
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
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SplashView(),
            ),
      ),
      GoRoute(
        path: Routes.onboarding,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const OnBoardingView(),
            ),
      ),
      // GoRoute(
      //   path: Routes.register,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage(
      //         key: state.pageKey,
      //         child: const LoginInfoView(),
      //       ),
      // ),
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
