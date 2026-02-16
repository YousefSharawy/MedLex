import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/app/di.dart';
import 'package:transly/cubit/terms_cubit.dart';
import 'package:transly/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:transly/presentation/home/viewModel/cubit/home_cubit.dart';
import 'package:transly/presentation/search/viewModel/cubit/navigation_cubit.dart';
import 'package:transly/presentation/search/viewModel/cubit/search_cubit.dart';

import '../presentation/resources/constants_manager.dart';
import '../presentation/resources/routes.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (_) => getIt<AuthCubit>()..initialize(),
              lazy: false,
            ),
            BlocProvider<HomeCubit>(
              create: (context) => getIt<HomeCubit>()..getDailyTerm(),
            ),
            BlocProvider<SearchCubit>(
              create: (context) => getIt<SearchCubit>(),
            ),
            BlocProvider<TermsCubit>(create: (context) => getIt<TermsCubit>()),
            BlocProvider<NavigationCubit>(
              create: (context) => getIt<NavigationCubit>(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: ConstantsManager.appName,
            theme: getApplicationTheme(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: AppNavigation.router,
          ),
        );
      },
      designSize: const Size(375, 812),
    );
  }
}
