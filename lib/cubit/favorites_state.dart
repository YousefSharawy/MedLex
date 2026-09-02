part of 'favorites_cubit.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = _FavoritesInitial;

  const factory FavoritesState.favoritesLoading() = FavoritesLoading;
  const factory FavoritesState.favoritesUpdated({
    @Default([]) List<int> favoriteIds,
  }) = FavoritesUpdated;

  const factory FavoritesState.favoritesLoaded(List<TermModel> favorites) =
      FavoritesLoaded;
}
