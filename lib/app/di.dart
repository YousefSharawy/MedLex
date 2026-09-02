import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medlex/app/adds/viewModel/ad_repository.dart';
import 'package:medlex/app/adds/viewModel/ad_view_model.dart';
import 'package:medlex/app/tts_service.dart';
import 'package:medlex/cubit/favorites_cubit.dart';
import 'package:medlex/cubit/recently_viewed_cubit.dart';
import 'package:medlex/cubit/terms_cubit.dart';
import 'package:medlex/data/remote_data_source.dart';
import 'package:medlex/data/repository_impl.dart';
import 'package:medlex/domain/repository.dart';
import 'package:medlex/presentation/auth/viewModel/cubit/auth_cubit.dart';
import 'package:medlex/presentation/dictionary/viewModel/cubit/az_list_cubit.dart';
import 'package:medlex/presentation/home/viewModel/cubit/home_cubit.dart';
import 'package:medlex/presentation/search/viewModel/cubit/navigation_cubit.dart';
import 'package:medlex/presentation/search/viewModel/cubit/search_cubit.dart';
import 'package:medlex/presentation/termDetails/viewModel/cubit/term_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // SharedPreferences & Tutorial

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

  // Cubits — existing
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerLazySingleton<TermsCubit>(() => TermsCubit(getIt()));
  getIt.registerLazySingleton<FavoritesCubit>(() => FavoritesCubit(getIt()));
  getIt.registerLazySingleton<RecentlyViewedCubit>(() => RecentlyViewedCubit());
  getIt.registerFactory<TermDetailsCubit>(() => TermDetailsCubit(getIt()));
  getIt.registerFactory<AzListCubit>(() => AzListCubit());
  getIt.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
  getIt.registerSingleton<AuthCubit>(AuthCubit(getIt()));


  // Ads
  getIt.registerLazySingleton<AdRepository>(() => AdRepositoryImpl());
  getIt.registerLazySingleton<AdViewModel>(() => AdViewModel(getIt()));
}
