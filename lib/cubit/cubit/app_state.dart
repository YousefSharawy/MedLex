part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _Initial;
  
  // Daily Term States
  const factory AppState.dailyTermLoading() = DailyTermLoading;
  const factory AppState.dailyTermLoaded(TermModel term) = DailyTermLoaded;
  const factory AppState.dailyTermError(String message) = DailyTermError;
  
  // Search States
  const factory AppState.searchLoading() = SearchLoading;
  const factory AppState.searchLoaded(List<TermModel> terms) = SearchLoaded;
  const factory AppState.searchEmpty() = SearchEmpty;
  const factory AppState.searchError(String message) = SearchError;
  
  // Categories States
  const factory AppState.categoriesLoading() = CategoriesLoading;
  const factory AppState.categoriesLoaded(List<String> categories) = CategoriesLoaded;
  const factory AppState.categoriesError(String message) = CategoriesError;
  
  // Terms by Category States
  const factory AppState.termsByCategoryLoading() = TermsByCategoryLoading;
  const factory AppState.termsByCategoryLoaded(List<TermModel> terms) = TermsByCategoryLoaded;
  const factory AppState.termsByCategoryError(String message) = TermsByCategoryError;
  
  // Term Details States
  const factory AppState.termDetailsLoading() = TermDetailsLoading;
  const factory AppState.termDetailsLoaded(TermModel term) = TermDetailsLoaded;
  const factory AppState.termDetailsError(String message) = TermDetailsError;

  const factory AppState.homeLoaded({
    required TermModel? dailyTerm,
    required bool isSearching,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = HomeLoaded;
}