import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medlex/app/local_storage.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/domain/repository.dart';
part 'favorites_state.dart';
part 'favorites_cubit.freezed.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final Repository _repository;

  List<int> _favoriteIds = [];
  bool _isSyncing = false;

  FavoritesCubit(this._repository) : super(const FavoritesState.initial()) {
    _loadFavoriteIds();

    Future.microtask(() {
      syncFavoritesFromRemote();
    });
  }

  void _safeEmit(FavoritesState state) {
    if (!isClosed) emit(state);
  }

  void _loadFavoriteIds() {
    final favorites = LocalAppStorage.getFavorites();
    _favoriteIds = favorites.map((term) => term.id).toList();
  }

  List<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int termId) => _favoriteIds.contains(termId);

  /// Saves [term] locally, then mirrors it remotely.
  ///
  /// Returns false when local storage rejected the write. In that case
  /// [_favoriteIds] is deliberately left untouched: showing a filled bookmark
  /// for something that was not stored would be a lie the user only discovers
  /// after a restart.
  Future<bool> _persistFavoriteAdd(TermModel term) async {
    try {
      await LocalAppStorage.addFavorite(term);
    } catch (_) {
      return false;
    }
    _remoteFavoriteAdd(term.id);
    _loadFavoriteIds();
    return true;
  }

  /// Removes [termId] locally, then mirrors it remotely. See
  /// [_persistFavoriteAdd] for the failure contract.
  Future<bool> _persistFavoriteRemove(int termId) async {
    try {
      await LocalAppStorage.removeFavorite(termId);
    } catch (_) {
      return false;
    }
    _remoteFavoriteRemove(termId);
    _loadFavoriteIds();
    return true;
  }

  Future<bool> _toggleFavorite(TermModel term) => isFavorite(term.id)
      ? _persistFavoriteRemove(term.id)
      : _persistFavoriteAdd(term);

  void _emitFavorites() {
    if (isClosed) return;
    _safeEmit(
      FavoritesState.favoritesUpdated(favoriteIds: List.from(_favoriteIds)),
    );
  }

  Future<void> toggleFavorite(TermModel term) async {
    if (!await _toggleFavorite(term)) return _emitFavorites();
    loadFavorites();
    _emitFavorites();
  }

  Future<void> toggleFavoriteInSavedView(TermModel term) async {
    if (!await _toggleFavorite(term)) return _emitFavorites();
    if (isClosed) return;
    _safeEmit(FavoritesState.favoritesLoaded(LocalAppStorage.getFavorites()));
  }

  Future<void> addToFavorites(TermModel term) async {
    if (isFavorite(term.id)) return;
    await _persistFavoriteAdd(term);
    _emitFavorites();
  }

  Future<void> removeFromFavorites(int termId) async {
    if (!isFavorite(termId)) return;
    await _persistFavoriteRemove(termId);
    _emitFavorites();
  }

  void loadFavorites() {
    final favorites = LocalAppStorage.getFavorites();
    _favoriteIds = favorites.map((term) => term.id).toList();
    _safeEmit(FavoritesState.favoritesLoaded(favorites));
  }

  // ==================== REMOTE FAVORITES SYNC ====================

  // Fire-and-forget mirroring: the local store is the source of truth for the
  // UI, and reconcileFavorites() repairs any divergence on the next launch.
  void _remoteFavoriteAdd(int termId) {
    _repository.addFavoriteRemotely(termId);
  }

  void _remoteFavoriteRemove(int termId) {
    _repository.removeFavoriteRemotely(termId);
  }

  Future<void> syncFavoritesFromRemote() async {
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      // Reconciling silently: emitting a loading state here would blank out
      // whatever the UI is already showing for a background repair.
      final reconciled = await _repository.reconcileFavorites();
      if (isClosed) return;
      reconciled.fold((_) {}, (favorites) {
        _favoriteIds = favorites.map((term) => term.id).toList();
        _safeEmit(FavoritesState.favoritesLoaded(favorites));
      });
    } finally {
      _isSyncing = false;
    }
  }

  /// Clears the user's saved terms everywhere.
  ///
  /// Returns `true` only when the saved terms were removed remotely. The
  /// remote delete runs *first* and the local copy is kept when it fails:
  /// clearing locally while the rows still exist server-side would look like
  /// it worked and then quietly undo itself — [syncFavoritesFromRemote] runs
  /// on the next launch, sees the terms missing locally, and downloads every
  /// one of them back. Keeping both sides populated leaves the user somewhere
  /// honest that they can retry from.
  Future<bool> clearAllFavorites() async {
    final removedRemotely =
        (await _repository.removeAllUserFavorites()).isRight();
    if (!removedRemotely) return false;

    await LocalAppStorage.clearFavorites();
    _favoriteIds = [];
    _safeEmit(const FavoritesState.favoritesUpdated(favoriteIds: []));
    return true;
  }
}
