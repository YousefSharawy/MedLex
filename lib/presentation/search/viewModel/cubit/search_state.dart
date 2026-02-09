part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _SearchInitial;

  const factory SearchState.loaded({
    @Default(false) bool isSearching,
    List<TermModel>? searchResults,
    @Default(false) bool isSearchLoading,
    String? searchError,
    @Default([]) List<String> recentlySearched,
    String? pendingSearchText,
  }) = SearchLoaded;
}