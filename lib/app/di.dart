import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:transly/app/adds/viewModel/ad_repository.dart';
import 'package:transly/app/adds/viewModel/ad_view_model.dart';
import 'package:transly/app/tts_service.dart';
import 'package:transly/cubit/terms_cubit.dart';
import 'package:transly/data/remote_data_source.dart';
import 'package:transly/data/repository_impl.dart';
import 'package:transly/domain/repository.dart';
import 'package:transly/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:transly/presentation/dictionary/viewModel/cubit/az_list_cubit.dart';
import 'package:transly/presentation/home/viewModel/cubit/home_cubit.dart';
import 'package:transly/presentation/search/viewModel/cubit/navigation_cubit.dart';
import 'package:transly/presentation/search/viewModel/cubit/search_cubit.dart';
import 'package:transly/presentation/termDetails/viewModel/cubit/term_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // TTS Service
  getIt.registerLazySingleton<TtsService>(() => TtsService());

  // Supabase client
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Remote data source
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(supabase: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<Repository>(() => RepositoryImpl(getIt()));

  // Cubits
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerLazySingleton<TermsCubit>(() => TermsCubit(getIt(),getIt(),getIt()));
  getIt.registerFactory<TermDetailsCubit>(() => TermDetailsCubit(getIt()));
  getIt.registerFactory<AzListCubit>(() => AzListCubit());
  getIt.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
  getIt.registerSingleton<AuthCubit>(AuthCubit(getIt()));


    getIt.registerLazySingleton<AdRepository>(() => AdRepositoryImpl());
  getIt.registerLazySingleton<AdViewModel>(() => AdViewModel(getIt()));
}
