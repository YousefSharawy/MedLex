import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/app/local_storage.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/domain/repository.dart';

part 'terms_state.dart';
part 'terms_cubit.freezed.dart';

class TermsCubit extends Cubit<TermsState> {
  final Repository _repository;

  // Favorites
  List<int> _favoriteIds = [];

  // Recently Viewed
  List<TermModel> _recentlyViewed = [];

  // Category State Tracking
  String? _currentCategory;

  // Loading lock to prevent concurrent loads
  bool _isLoadingTerms = false;

  // Flag to cancel letter loading
  bool _cancelLetterLoading = false;

  // Total count
  int _totalCount = 0;

  static const int _pageSize = 30;
  static const int _maxLetterLoadIterations = 50;

  TermsCubit(this._repository) : super(const TermsState.initial()) {
  _loadFavoriteIds();
  _recentlyViewed = LocalAppStorage.getRecentlyViewed();

  Future.microtask(() {
    _safeEmit(TermsState.recentlyViewedUpdated(
      recentlyViewed: List.from(_recentlyViewed),
    ));
  });
}

  /// Safe emit that checks if cubit is still open
  void _safeEmit(TermsState state) {
    if (!isClosed) emit(state);
  }

  void _loadFavoriteIds() {
    final favorites = LocalAppStorage.getFavorites();
    _favoriteIds = favorites.map((term) => term.id).toList();
  }

  // ==================== GETTERS ====================

  List<int> get favoriteIds => _favoriteIds;
  List<TermModel> get recentlyViewed => _recentlyViewed;
  String? get currentCategory => _currentCategory;

  AllTermsLoaded? get _allTermsState {
    final s = state;
    return s is AllTermsLoaded ? s : null;
  }

  String? get pendingLetter => _allTermsState?.pendingLetter;

  // ==================== FAVORITES ====================

  bool isFavorite(int termId) {
    return _favoriteIds.contains(termId);
  }

  Future<void> toggleFavorite(TermModel term) async {
    if (isFavorite(term.id)) {
      await LocalAppStorage.removeFavorite(term.id);
      _favoriteIds.remove(term.id);
    } else {
      await LocalAppStorage.addFavorite(term);
      _favoriteIds.add(term.id);
    }
    _safeEmit(TermsState.favoritesUpdated(favoriteIds: List.from(_favoriteIds)));
  }

  Future<void> toggleFavoriteInSavedView(TermModel term) async {
    if (isFavorite(term.id)) {
      await LocalAppStorage.removeFavorite(term.id);
      _favoriteIds.remove(term.id);
    } else {
      await LocalAppStorage.addFavorite(term);
      _favoriteIds.add(term.id);
    }
    if (isClosed) return;
    final favorites = LocalAppStorage.getFavorites();
    _safeEmit(TermsState.favoritesLoaded(favorites));
  }

  Future<void> addToFavorites(TermModel term) async {
    if (!isFavorite(term.id)) {
      await LocalAppStorage.addFavorite(term);
      _favoriteIds.add(term.id);
      _safeEmit(TermsState.favoritesUpdated(favoriteIds: List.from(_favoriteIds)));
    }
  }

  Future<void> removeFromFavorites(int termId) async {
    if (isFavorite(termId)) {
      await LocalAppStorage.removeFavorite(termId);
      _favoriteIds.remove(termId);
      _safeEmit(TermsState.favoritesUpdated(favoriteIds: List.from(_favoriteIds)));
    }
  }

  void loadFavorites() {
    final favorites = LocalAppStorage.getFavorites();
    _favoriteIds = favorites.map((term) => term.id).toList();
    _safeEmit(TermsState.favoritesLoaded(favorites));
  }

  // ==================== RECENTLY VIEWED ====================

  Future<void> addToRecentlyViewed(TermModel term) async {
    await LocalAppStorage.addRecentlyViewed(term);
    _recentlyViewed = LocalAppStorage.getRecentlyViewed();
    _safeEmit(TermsState.recentlyViewedUpdated(
      recentlyViewed: List.from(_recentlyViewed),
    ));
  }

  // ==================== HELPER METHODS ====================

  /// Get total count from cache or API
  Future<int> _getTotalCount() async {
    if (_totalCount > 0) return _totalCount;

    final cachedCount = LocalAppStorage.getCachedTotalCount();
    if (cachedCount != null && cachedCount > 0) {
      _totalCount = cachedCount;
      return _totalCount;
    }

    final countResult = await _repository.getTotalTermsCount();

    final count = countResult.fold<int?>(
      (failure) => null,
      (count) => count,
    );

    if (count != null) {
      _totalCount = count;
      LocalAppStorage.cacheTotalCount(count);
    }

    return _totalCount;
  }

  /// Get first letter of a term (A-Z or #)
  String _getFirstLetter(String term) {
    if (term.isEmpty) return '#';
    final firstChar = term[0].toUpperCase();
    return RegExp(r'^[A-Z]$').hasMatch(firstChar) ? firstChar : '#';
  }

  /// Group terms by first letter
  Map<String, List<TermModel>> _groupTermsByLetter(List<TermModel> terms) {
    final Map<String, List<TermModel>> grouped = {};

    for (final term in terms) {
      final letter = _getFirstLetter(term.latinTerm);
      grouped.putIfAbsent(letter, () => []).add(term);
    }

    // Sort each group alphabetically
    for (final list in grouped.values) {
      list.sort((a, b) => a.latinTerm.compareTo(b.latinTerm));
    }

    return grouped;
  }

  /// Check if a letter exists in the given terms
  bool _termsContainLetter(List<TermModel> terms, String letter) {
    return terms.any((term) => _getFirstLetter(term.latinTerm) == letter);
  }

  /// Check if a letter is available in current state
  bool isLetterAvailable(String letter) {
    final currentState = _allTermsState;
    if (currentState == null) return false;
    return _termsContainLetter(currentState.terms, letter);
  }

  // ==================== ALL TERMS (PAGINATED) ====================

  /// Emit AllTermsLoaded state with computed groupedTerms
  void _emitAllTermsLoaded({
    required List<TermModel> terms,
    required int currentPage,
    required int totalCount,
    bool isLoadingMore = false,
    String? pendingLetter,
    String? letterJustLoaded,
  }) {
    final hasMore = terms.length < totalCount;
    final grouped = _groupTermsByLetter(terms);

    _safeEmit(
      TermsState.allTermsLoaded(
        terms: terms,
        hasMore: hasMore,
        currentPage: currentPage,
        totalCount: totalCount,
        isLoadingMore: isLoadingMore,
        pendingLetter: pendingLetter,
        letterJustLoaded: letterJustLoaded,
        groupedTerms: grouped,
      ),
    );
  }

  /// Load initial all terms
  Future<void> getAllTerms({bool refresh = false}) async {
    _currentCategory = 'All';
    _cancelLetterLoading = true;

    final totalCount = await _getTotalCount();
    if (isClosed) return;

    // Check cache first (unless refreshing)
    if (!refresh) {
      final cachedTerms = LocalAppStorage.getCachedAllTerms(0);
      if (cachedTerms != null && cachedTerms.isNotEmpty) {
        _emitAllTermsLoaded(
          terms: cachedTerms,
          currentPage: 0,
          totalCount: totalCount,
        );
        return;
      }
    }

    _safeEmit(const TermsState.allTermsLoading());

    final result = await _repository.getAllTerms(page: 0, pageSize: _pageSize);
    if (isClosed) return;

    final terms = result.fold<List<TermModel>?>(
      (failure) {
        _safeEmit(TermsState.allTermsError(failure.message));
        return null;
      },
      (terms) => terms,
    );

    if (terms != null) {
      await LocalAppStorage.cacheAllTerms(0, terms);
      if (isClosed) return;
      _emitAllTermsLoaded(
        terms: terms,
        currentPage: 0,
        totalCount: totalCount,
      );
    }
  }

  /// Load more terms (pagination)
  Future<void> loadMoreTerms() async {
    final currentState = _allTermsState;
    if (currentState == null) return;
    if (!currentState.hasMore) return;
    if (_isLoadingTerms) return;

    _isLoadingTerms = true;

    try {
      _safeEmit(currentState.copyWith(isLoadingMore: true));

      final nextPage = currentState.currentPage + 1;

      // Try cache first
      final cachedTerms = LocalAppStorage.getCachedAllTerms(nextPage);
      if (cachedTerms != null && cachedTerms.isNotEmpty) {
        final allTerms = [...currentState.terms, ...cachedTerms];
        _emitAllTermsLoaded(
          terms: allTerms,
          currentPage: nextPage,
          totalCount: currentState.totalCount,
        );
        return;
      }

      // Fetch from API
      final result = await _repository.getAllTerms(
        page: nextPage,
        pageSize: _pageSize,
      );
      if (isClosed) return;

      final terms = result.fold<List<TermModel>?>(
        (failure) => null,
        (terms) => terms,
      );

      if (terms != null) {
        await LocalAppStorage.cacheAllTerms(nextPage, terms);
        if (isClosed) return;
        final allTerms = [...currentState.terms, ...terms];
        _emitAllTermsLoaded(
          terms: allTerms,
          currentPage: nextPage,
          totalCount: currentState.totalCount,
        );
      } else {
        _safeEmit(currentState.copyWith(isLoadingMore: false));
      }
    } finally {
      _isLoadingTerms = false;
    }
  }

  // ==================== LETTER LOADING ====================

  Future<void> loadTermsUntilLetter(String letter) async {
    final currentState = _allTermsState;
    if (currentState == null) return;

    if (currentState.pendingLetter == letter) return;

    if (isLetterAvailable(letter)) {
      _safeEmit(
        currentState.copyWith(letterJustLoaded: letter, pendingLetter: null),
      );
      return;
    }

    if (!currentState.hasMore) return;

    _cancelLetterLoading = false;

    _safeEmit(
      currentState.copyWith(pendingLetter: letter, letterJustLoaded: null),
    );

    await _loadUntilLetterFound(letter);
  }

  Future<void> _loadUntilLetterFound(String letter) async {
    int outerIterations = 0;

    while (!_cancelLetterLoading && !isClosed) {
      outerIterations++;
      if (outerIterations > _maxLetterLoadIterations) {
        // Safety limit reached — stop loading
        final currentState = _allTermsState;
        if (currentState != null) {
          _safeEmit(currentState.copyWith(pendingLetter: null));
        }
        return;
      }

      final currentState = _allTermsState;
      if (currentState == null) break;

      if (_termsContainLetter(currentState.terms, letter)) {
        _safeEmit(
          currentState.copyWith(pendingLetter: null, letterJustLoaded: letter),
        );
        return;
      }
      if (!currentState.hasMore) {
        _safeEmit(currentState.copyWith(pendingLetter: null));
        return;
      }

      if (_isLoadingTerms) {
        await Future.delayed(const Duration(milliseconds: 100));
        continue;
      }

      _isLoadingTerms = true;

      try {
        List<TermModel> accumulatedTerms = List.from(currentState.terms);
        int page = currentState.currentPage;
        bool hasMore = currentState.hasMore;
        bool letterFound = false;
        int innerIterations = 0;

        while (!_cancelLetterLoading &&
            !isClosed &&
            hasMore &&
            !letterFound) {
          innerIterations++;
          if (innerIterations > _maxLetterLoadIterations) break;

          page++;

          List<TermModel>? newTerms;
          final cachedTerms = LocalAppStorage.getCachedAllTerms(page);

          if (cachedTerms != null && cachedTerms.isNotEmpty) {
            newTerms = cachedTerms;
          } else {
            final result = await _repository.getAllTerms(
              page: page,
              pageSize: _pageSize,
            );

            if (isClosed) return;

            newTerms = result.fold<List<TermModel>?>(
              (failure) {
                _cancelLetterLoading = true;
                return null;
              },
              (terms) => terms,
            );

            // Cache the fetched terms
            if (newTerms != null) {
              await LocalAppStorage.cacheAllTerms(page, newTerms);
              if (isClosed) return;
            }
          }

          if (_cancelLetterLoading || isClosed || newTerms == null) break;

          accumulatedTerms.addAll(newTerms);
          hasMore = newTerms.length >= _pageSize &&
              accumulatedTerms.length < currentState.totalCount;
          letterFound = _termsContainLetter(newTerms, letter);
        }

        // === SINGLE EMIT at the end ===
        if (_cancelLetterLoading || isClosed) {
          final s = _allTermsState;
          if (s != null && s.pendingLetter != null) {
            _safeEmit(s.copyWith(pendingLetter: null));
          }
          return;
        }

        _emitAllTermsLoaded(
          terms: accumulatedTerms,
          currentPage: page,
          totalCount: currentState.totalCount,
          pendingLetter: letterFound ? null : (hasMore ? letter : null),
          letterJustLoaded: letterFound ? letter : null,
        );

        if (letterFound || !hasMore) return;
      } finally {
        _isLoadingTerms = false;
      }
    }

    // Cancelled or closed — clear pending letter
    if (!isClosed) {
      final s = _allTermsState;
      if (s != null && s.pendingLetter != null) {
        _safeEmit(s.copyWith(pendingLetter: null));
      }
    }
  }

  /// Cancel pending letter loading
  void cancelLetterLoading() {
    _cancelLetterLoading = true;
    final currentState = _allTermsState;
    if (currentState != null && currentState.pendingLetter != null) {
      _safeEmit(
        currentState.copyWith(pendingLetter: null, isLoadingMore: false),
      );
    }
  }

  void clearLetterJustLoaded() {
    final currentState = _allTermsState;
    if (currentState != null && currentState.letterJustLoaded != null) {
      _safeEmit(currentState.copyWith(letterJustLoaded: null));
    }
  }

  // ==================== CATEGORY ====================

  Future<void> getTermsByCategory(String category) async {
    _currentCategory = category;
    _cancelLetterLoading = true;

    final cachedTerms = LocalAppStorage.getCachedCategoryTerms(category);
    if (cachedTerms != null) {
      _safeEmit(TermsState.termsByCategoryLoaded(cachedTerms));
      return;
    }

    _safeEmit(const TermsState.termsByCategoryLoading());

    final result = await _repository.getTermsByCategory(category);
    if (isClosed) return;

    final terms = result.fold<List<TermModel>?>(
      (failure) {
        _safeEmit(TermsState.termsByCategoryError(failure.message));
        return null;
      },
      (terms) => terms,
    );

    if (terms != null) {
      await LocalAppStorage.cacheCategoryTerms(category, terms);
      if (isClosed) return;
      _safeEmit(TermsState.termsByCategoryLoaded(terms));
    }
  }

  // ==================== CACHE MANAGEMENT ====================

  void resetState() {
    _totalCount = 0;
    _currentCategory = null;
    _cancelLetterLoading = true;
  }

  // ==================== CLOSE ====================

  @override
  Future<void> close() {
    _cancelLetterLoading = true;
    return super.close();
  }
}