// routes.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/presentation/profile/view/screens/recentlyViewed/recently_viewed_view.dart';
import 'package:medlex/presentation/splash/viewModel/splash_cubit.dart';
import 'package:medlex/presentation/termDetails/view/term_details_view.dart';
import 'package:medlex/presentation/onboarding/on_boarding_view.dart';
import 'package:medlex/presentation/profile/view/screens/savedTerms/saved_terms_view.dart';

import '../../presentation/home/view/home_view.dart';
import '../../presentation/dictionary/view/dictionary_view.dart';
import '../../presentation/profile/profile_view.dart';
import '../../presentation/splash/view/splash_view.dart';
import 'package:medlex/presentation/base/scaffold_with_nav_bar.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2 = '/onboarding2';
  static const String home = '/home';
  static const String dictionary = '/dictionary';
  static const String profile = '/profile';
  static const String savedItems = '/savedItems';
  static const String recentlyViewed = '/recentlyViewed';
  static const String termDetails = '/termDetails';
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
        child: BlocProvider(
          create: (_) => SplashCubit(),
          child: const SplashView(),
        ),
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
        path: Routes.recentlyViewed,
        pageBuilder:
            (context, state) => CustomTransitionPage2(
              key: state.pageKey,
              child: const RecentlyViewedView(),
            ),
      ),
      GoRoute(
        path: Routes.savedItems,
        pageBuilder:
            (context, state) => CustomTransitionPage2(
              key: state.pageKey,
              child: const SavedTermsView(),
            ),
      ),
      GoRoute(
        path: Routes.termDetails,
        builder: (context, state) {
          final term = state.extra as TermModel;
          return TermDetailsView(term: term);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.home,
                pageBuilder:
                    (context, state) => CustomTransitionPage2(
                      key: state.pageKey,
                      child: const HomeView(),
                    ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.dictionary,
                pageBuilder:
                    (context, state) => CustomTransitionPage2(
                      key: state.pageKey,
                      child: const DictionaryView(),
                    ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.profile,
                pageBuilder:
                    (context, state) => CustomTransitionPage2(
                      key: state.pageKey,
                      child: ProfileView(),
                    ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Custom transition with cross-fade masked by a diagonal light sweep.
/// The light travels from primaryTeal button area (bottom-right) to back button (top-left)
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

        return FadeTransition(opacity: fadeAnimation, child: child);
      },
    );
  }
}
