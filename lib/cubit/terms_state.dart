part of 'terms_cubit.dart';

@freezed
class TermsState with _$TermsState {
  const factory TermsState.initial() = _TermsInitial;

  // ==================== FAVORITES ====================
const factory TermsState.favoritesLoading() = FavoritesLoading;
  const factory TermsState.favoritesUpdated({
    @Default([]) List<int> favoriteIds,
  }) = FavoritesUpdated;

  const factory TermsState.favoritesLoaded(List<TermModel> favorites) =
      FavoritesLoaded;

  // ==================== RECENTLY VIEWED ====================

  const factory TermsState.recentlyViewedUpdated({
    @Default([]) List<TermModel> recentlyViewed,
  }) = RecentlyViewedUpdated;

  // ==================== ALL TERMS ====================

  const factory TermsState.allTermsLoading() = AllTermsLoading;

  const factory TermsState.allTermsLoaded({
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

  const factory TermsState.allTermsError(String message) = AllTermsError;

  // ==================== CATEGORY ====================

  const factory TermsState.termsByCategoryLoading() = TermsByCategoryLoading;

  const factory TermsState.termsByCategoryLoaded(List<TermModel> terms) =
      TermsByCategoryLoaded;

  const factory TermsState.termsByCategoryError(String message) =
      TermsByCategoryError;
}