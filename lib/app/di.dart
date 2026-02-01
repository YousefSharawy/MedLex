import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:transly/app/tts_service.dart';
import 'package:transly/cubit/cubit/app_cubit.dart';
import 'package:transly/data/remote_data_source.dart';
import 'package:transly/data/repository_impl.dart';
import 'package:transly/domain/repository.dart';
import 'package:transly/presentation/search/view_model/cubit/navigation_cubit.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // TTS Service
  getIt.registerLazySingleton<TtsService>(
    () => TtsService(),
  );

  // Supabase client
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  // Remote data source
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(supabase: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<AppCubit>(
    () => AppCubit(getIt()),
  );
  getIt.registerLazySingleton<NavigationCubit>(
    () => NavigationCubit(),
  );
}