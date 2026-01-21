import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../resources/constants_manager.dart';
import '../../resources/routes.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

class SplashCubit extends Cubit<SplashState> {
  // final AppPrefs _appPrefs;
  SplashCubit() : super(SplashState.initial());

  void start() async {
    await Future.delayed(Duration(seconds: ConstantsManager.splashTimer));
    emit(SplashState.success(route: Routes.onboarding1));
    // final authStream = FirebaseAuth.instance.authStateChanges();
    // authStream.listen((User? user) {
    //   if (user == null) {
    //     emit(SplashState.success(route: Routes.login));
    //     getIt<AppPrefs>().saveUserId('');
    //   } else {
    //     TODO:
    //     emit(SplashState.success(route: Routes.home));
    //     getIt<AppPrefs>().saveUserId(user.uid);
    //   }
    // });
  }
}
