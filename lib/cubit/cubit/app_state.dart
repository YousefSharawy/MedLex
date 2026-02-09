part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _Initial;

  const factory AppState.homeLoaded({
    TermModel? dailyTerm,
    @Default(false) bool isSearching,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default([]) List<TermModel> recentlyViewed,
    @Default([]) List<String> recentlySearched,
    @Default([]) List<int> favoriteIds,
    List<TermModel>? searchResults,
    @Default(false) bool isSearchLoading,
    String? searchError,
    @Default([]) List<TermModel> popularTerms,
    @Default([]) List<TermModel> trendingTerms,
    String? pendingSearchText,
  }) = HomeLoaded;

  const factory AppState.termsByCategoryLoading() = TermsByCategoryLoading;
  const factory AppState.termsByCategoryLoaded(List<TermModel> terms) = TermsByCategoryLoaded;
  const factory AppState.termsByCategoryError(String message) = TermsByCategoryError;

  const factory AppState.termDetailsLoading() = TermDetailsLoading;
  const factory AppState.termDetailsLoaded(TermModel term) = TermDetailsLoaded;
  const factory AppState.termDetailsError(String message) = TermDetailsError;

  const factory AppState.favoritesLoaded(List<TermModel> favorites) = FavoritesLoaded;

  const factory AppState.allTermsLoading() = AllTermsLoading;
  const factory AppState.allTermsLoaded({
    required List<TermModel> terms,
    required bool hasMore,
    required int currentPage,
    required int totalCount,
    @Default(false) bool isLoadingMore,
    String? pendingLetter,
    String? letterJustLoaded,
    @Default(false) bool isLetterLoading,
    @Default({}) Map<String, List<TermModel>> groupedTerms,
  }) = AllTermsLoaded;

  const factory AppState.allTermsError(String message) = AllTermsError;
}