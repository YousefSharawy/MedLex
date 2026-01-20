import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/remote_data_source.dart';
import '../data/repository_impl.dart';
import '../domain/repository.dart';
import 'app_prefs.dart';

final getIt = GetIt.instance;

Future<void> getAppModules() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));
  
  final supabase = Supabase.instance.client;
  
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(supabase: supabase),
  );

  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(getIt<RemoteDataSource>()),
  );
}