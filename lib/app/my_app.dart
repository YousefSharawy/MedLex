import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transly/app/di.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/presentation/dictionary/viewModel/cubit/az_list_cubit.dart';
import 'package:transly/presentation/search/viewModel/cubit/navigation_cubit.dart';

import '../presentation/resources/constants_manager.dart';
import '../presentation/resources/routes.dart';
import '../presentation/resources/theme_manager.dart';
import '../presentation/splash/viewModel/splash_cubit.dart';

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
            BlocProvider(create: (context) => SplashCubit()),
            BlocProvider<AppCubit>(
              create: (context) => getIt<AppCubit>()..getDailyTerm(),
            ),
            BlocProvider<AzListCubit>(
              create: (context) => getIt<AzListCubit>(),
            ),
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