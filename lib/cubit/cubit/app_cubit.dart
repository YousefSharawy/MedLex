import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/app/local_storage.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/domain/repository.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  final Repository _repository;

  // Daily Term
  TermModel? _dailyTerm;

  bool _isSearching = false;
  List<TermModel>? _searchResults;
  bool _isSearchLoading = false;
  String? _searchError;
  String? _pendingSearchText;

  // Recently Viewed & Searched
  List<TermModel> _recentlyViewed = [];
  List<String> _recentlySearched = [];

  // Favorites
  List<int> _favoriteIds = [];

  // Popular & Trending
  List<TermModel> _popularTerms = [];
  List<TermModel> _trendingTerms = [];

  // Total count (shared across features)
  int _totalCount = 0;

  // Category State Tracking
  String? _currentCategory;

  // Loading lock to prevent concurrent loads
  bool _isLoadingTerms = false;

  // Flag to cancel letter loading
  bool _cancelLetterLoading = false;

  static const int _pageSize = 30;

  AppCubit(this._repository) : super(const AppState.initial()) {
    _recentlyViewed = LocalAppStorage.getRecentlyViewed();
    _recentlySearched = LocalAppStorage.getRecentlySearched();
    _loadFavoriteIds();
  }

  void _loadFavoriteIds() {
    final favorites = LocalAppStorage.getFavorites();
    _favoriteIds = favorites.map((term) => term.id).toList();
  }

  // ==================== GETTERS ====================

  bool get isSearching => _isSearching;
  TermModel? get dailyTerm => _dailyTerm;
  List<TermModel> get recentlyViewed => _recentlyViewed;
  List<String> get recentlySearched => _recentlySearched;
  List<int> get favoriteIds => _favoriteIds;
  List<TermModel> get popularTerms => _popularTerms;
  List<TermModel> get trendingTerms => _trendingTerms;
  String? get pendingSearchText => _pendingSearchText;
  String? get currentCategory => _currentCategory;

  /// Get current AllTermsLoaded state or null
  AllTermsLoaded? get _allTermsState {
    final s = state;
    return s is AllTermsLoaded ? s : null;
  }

  /// Get pending letter from current state
  String? get pendingLetter => _allTermsState?.pendingLetter;

  // ==================== SEARCH STATE ====================

  void setSearching(bool value) {
    _isSearching = value;
    if (!value) {
      _searchResults = null;
      _isSearchLoading = false;
      _searchError = null;
      _pendingSearchText = null;
    }
    _emitHomeState();
  }

  void setSearchTextAndActivate(String text) {
    _pendingSearchText = text;
    _isSearching = true;
    _emitHomeState();
    searchTerms(text);
  }

  void clearPendingSearchText() {
    _pendingSearchText = null;
  }

  void resetHomeState() {
    _isSearching = false;
    _searchResults = null;
    _isSearchLoading = false;
    _searchError = null;
    _emitHomeState();
  }

  void _emitHomeState({bool isLoading = false, String? errorMessage}) {
    emit(
      AppState.homeLoaded(
        dailyTerm: _dailyTerm,
        isSearching: _isSearching,
        isLoading: isLoading,
        errorMessage: errorMessage,
        recentlyViewed: List.from(_recentlyViewed),
        recentlySearched: List.from(_recentlySearched),
        favoriteIds: List.from(_favoriteIds),
        searchResults:
            _searchResults != null ? List.from(_searchResults!) : null,
        isSearchLoading: _isSearchLoading,
        searchError: _searchError,
        popularTerms: List.from(_popularTerms),
        trendingTerms: List.from(_trendingTerms),
        pendingSearchText: _pendingSearchText,
      ),
    );
  }

  // ==================== TRENDING TERMS ====================

  Future<void> loadTrendingTerms() async {
    final cachedTrending = LocalAppStorage.getCachedDailyTrendingTerms();
    if (cachedTrending != null && cachedTrending.isNotEmpty) {
      _trendingTerms = cachedTrending;
      _emitHomeState();
      return;
    }

    int totalCount = await _getTotalCount();
    if (totalCount == 0) return;

    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;
    final random = Random(seed);

    final totalPages = (totalCount / 30).ceil();
    final randomPage = random.nextInt(totalPages.clamp(0, totalPages - 3));

    final List<TermModel> allTerms = [];
    for (int i = 0; i < 4; i++) {
      final result = await _repository.getAllTerms(
        page: randomPage + i,
        pageSize: 30,
      );
      result.fold((failure) => null, (terms) {
        allTerms.addAll(terms);
      });
    }

    if (allTerms.isNotEmpty) {
      final availableTerms =
          allTerms.where((term) {
            return !_popularTerms.any((popular) => popular.id == term.id);
          }).toList();

      _trendingTerms = _getDailyRandomTerms(availableTerms, 5);

      await LocalAppStorage.cacheDailyTrendingTerms(_trendingTerms);
      _emitHomeState();
    }
  }

  // ==================== POPULAR TERMS ====================

  Future<void> loadPopularTerms() async {
    int totalCount = await _getTotalCount();
    if (totalCount == 0) return;

    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;

    final popularSeed = Random(seed + 12345);
    final totalPages = (totalCount / 30).ceil();
    final randomPage = popularSeed.nextInt(totalPages.clamp(0, totalPages - 2));

    List<TermModel> termsForSelection = [];

    for (int i = 0; i < 2; i++) {
      final result = await _repository.getAllTerms(
        page: randomPage + i,
        pageSize: 30,
      );
      result.fold((failure) => null, (terms) {
        termsForSelection.addAll(terms);
      });
    }

    if (termsForSelection.isNotEmpty) {
      _popularTerms = _getDailyRandomTerms(termsForSelection, 4);
      _emitHomeState();

      await loadTrendingTerms();
    }
  }

  List<TermModel> _getDailyRandomTerms(List<TermModel> terms, int count) {
    if (terms.isEmpty) return [];

    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;
    final random = Random(seed);

    final shuffled = List<TermModel>.from(terms);
    shuffled.shuffle(random);

    return shuffled.take(count).toList();
  }

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
    _emitHomeState();
  }

  Future<void> toggleFavoriteInSavedView(TermModel term) async {
    if (isFavorite(term.id)) {
      await LocalAppStorage.removeFavorite(term.id);
      _favoriteIds.remove(term.id);
    } else {
      await LocalAppStorage.addFavorite(term);
      _favoriteIds.add(term.id);
    }
    final favorites = LocalAppStorage.getFavorites();
    emit(AppState.favoritesLoaded(favorites));
  }

  Future<void> addToFavorites(TermModel term) async {
    if (!isFavorite(term.id)) {
      await LocalAppStorage.addFavorite(term);
      _favoriteIds.add(term.id);
      _emitHomeState();
    }
  }

  Future<void> removeFromFavorites(int termId) async {
    if (isFavorite(termId)) {
      await LocalAppStorage.removeFavorite(termId);
      _favoriteIds.remove(termId);
      _emitHomeState();
    }
  }

  void loadFavorites() {
    final favorites = LocalAppStorage.getFavorites();
    _favoriteIds = favorites.map((term) => term.id).toList();
    emit(AppState.favoritesLoaded(favorites));
  }

  // ==================== RECENTLY VIEWED ====================

  Future<void> addToRecentlyViewed(TermModel term) async {
    await LocalAppStorage.addRecentlyViewed(term);
    _recentlyViewed = LocalAppStorage.getRecentlyViewed();
    _emitHomeState();
  }

  // ==================== RECENTLY SEARCHED ====================

  Future<void> addToRecentlySearched(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;

    await LocalAppStorage.addRecentlySearched(trimmedQuery);
    _recentlySearched = List.from(LocalAppStorage.getRecentlySearched());
    _emitHomeState();
  }

  Future<void> clearRecentlySearched() async {
    await LocalAppStorage.clearRecentlySearched();
    _recentlySearched = [];
    _emitHomeState();
  }

  // ==================== DAILY TERM ====================

  Future<void> getDailyTerm() async {
    _emitHomeState(isLoading: true);

    final cachedDailyTerm = LocalAppStorage.getCachedDailyTerm();
    if (cachedDailyTerm != null) {
      _dailyTerm = cachedDailyTerm;
      _emitHomeState();
      await loadPopularTerms();
      return;
    }

    final result = await _repository.getDailyTerm();

    result.fold(
      (failure) {
        _dailyTerm = null;
        _emitHomeState(errorMessage: failure.message);
      },
      (term) async {
        _dailyTerm = term;
        await LocalAppStorage.cacheDailyTerm(term);
        _emitHomeState();
      },
    );

    await loadPopularTerms();
  }

  // ==================== SEARCH ====================

  Future<void> searchTerms(String query) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      _searchResults = [];
      _isSearchLoading = false;
      _searchError = null;
      _emitHomeState();
      return;
    }

    await addToRecentlySearched(trimmedQuery);

    final cachedResults = LocalAppStorage.getCachedSearchResults(trimmedQuery);
    if (cachedResults != null) {
      _searchResults = cachedResults;
      _isSearchLoading = false;
      _searchError = null;
      _emitHomeState();
      return;
    }

    _isSearchLoading = true;
    _searchError = null;
    _emitHomeState();

    final result = await _repository.searchTerms(trimmedQuery);

    result.fold(
      (failure) {
        _searchResults = null;
        _isSearchLoading = false;
        _searchError = failure.message;
        _emitHomeState();
      },
      (terms) async {
        _searchResults = terms;
        _isSearchLoading = false;
        _searchError = null;
        await LocalAppStorage.cacheSearchResults(trimmedQuery, terms);
        _emitHomeState();
      },
    );
  }

  void clearSearchResults() {
    _searchResults = null;
    _isSearchLoading = false;
    _searchError = null;
    _emitHomeState();
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
    countResult.fold((failure) => null, (count) {
      _totalCount = count;
      LocalAppStorage.cacheTotalCount(count);
    });

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

    emit(
      AppState.allTermsLoaded(
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
    _cancelLetterLoading = true; // Cancel any ongoing letter loading

    final totalCount = await _getTotalCount();

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

    emit(const AppState.allTermsLoading());

    final result = await _repository.getAllTerms(page: 0, pageSize: _pageSize);

    result.fold((failure) => emit(AppState.allTermsError(failure.message)), (
      terms,
    ) async {
      await LocalAppStorage.cacheAllTerms(0, terms);
      _emitAllTermsLoaded(terms: terms, currentPage: 0, totalCount: totalCount);
    });
  }

  /// Load more terms (pagination) - simple version without letter loading
  Future<void> loadMoreTerms() async {
    final currentState = _allTermsState;
    if (currentState == null) return;
    if (!currentState.hasMore) return;
    if (_isLoadingTerms) return;

    _isLoadingTerms = true;

    try {
      emit(currentState.copyWith(isLoadingMore: true));

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

      result.fold(
        (failure) {
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (terms) async {
          await LocalAppStorage.cacheAllTerms(nextPage, terms);
          final allTerms = [...currentState.terms, ...terms];
          _emitAllTermsLoaded(
            terms: allTerms,
            currentPage: nextPage,
            totalCount: currentState.totalCount,
          );
        },
      );
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
      emit(
        currentState.copyWith(letterJustLoaded: letter, pendingLetter: null),
      );
      return;
    }

    if (!currentState.hasMore) return;

    _cancelLetterLoading = false;

    emit(currentState.copyWith(pendingLetter: letter, letterJustLoaded: null));

    await _loadUntilLetterFound(letter);
  }

  Future<void> _loadUntilLetterFound(String letter) async {
  while (!_cancelLetterLoading) {
    final currentState = _allTermsState;
    if (currentState == null) break;

    if (_termsContainLetter(currentState.terms, letter)) {
      emit(
        currentState.copyWith(pendingLetter: null, letterJustLoaded: letter),
      );
      return;
    }
    if (!currentState.hasMore) {
      emit(currentState.copyWith(pendingLetter: null));
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

      while (!_cancelLetterLoading && hasMore && !letterFound) {
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

          result.fold(
            (failure) {
              _cancelLetterLoading = true;
            },
            (terms) async {
              await LocalAppStorage.cacheAllTerms(page, terms);
              newTerms = terms;
            },
          );
        }

        if (_cancelLetterLoading || newTerms == null) break;

        accumulatedTerms.addAll(newTerms!);
        hasMore = newTerms!.length >= _pageSize &&
            accumulatedTerms.length < currentState.totalCount;
        letterFound = _termsContainLetter(newTerms!, letter);
      }

      // === SINGLE EMIT at the end ===
      if (_cancelLetterLoading) {
        final state = _allTermsState;
        if (state != null && state.pendingLetter != null) {
          emit(state.copyWith(pendingLetter: null));
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

  // Cancelled - clear pending letter
  final state = _allTermsState;
  if (state != null && state.pendingLetter != null) {
    emit(state.copyWith(pendingLetter: null));
  }
}
  /// Cancel pending letter loading
  void cancelLetterLoading() {
    _cancelLetterLoading = true;
    final currentState = _allTermsState;
    if (currentState != null && currentState.pendingLetter != null) {
      emit(currentState.copyWith(pendingLetter: null, isLoadingMore: false));
    }
  }

  void clearLetterJustLoaded() {
    final currentState = _allTermsState;
    if (currentState != null && currentState.letterJustLoaded != null) {
      emit(currentState.copyWith(letterJustLoaded: null));
    }
  }

  // ==================== CATEGORY ====================
  Future<void> getTermsByCategory(String category) async {
    _currentCategory = category;
    _cancelLetterLoading = true; // Cancel any ongoing letter loading

    final cachedTerms = LocalAppStorage.getCachedCategoryTerms(category);
    if (cachedTerms != null) {
      emit(AppState.termsByCategoryLoaded(cachedTerms));
      return;
    }

    emit(const AppState.termsByCategoryLoading());

    final result = await _repository.getTermsByCategory(category);

    result.fold(
      (failure) => emit(AppState.termsByCategoryError(failure.message)),
      (terms) async {
        await LocalAppStorage.cacheCategoryTerms(category, terms);
        emit(AppState.termsByCategoryLoaded(terms));
      },
    );
  }

  // ==================== TERM DETAILS ====================

  Future<void> getTermById(int id) async {
    emit(const AppState.termDetailsLoading());

    final result = await _repository.getTermById(id);

    result.fold(
      (failure) => emit(AppState.termDetailsError(failure.message)),
      (term) => emit(AppState.termDetailsLoaded(term)),
    );
  }

  // ==================== CACHE MANAGEMENT ====================

  Future<void> refreshAllData() async {
    await LocalAppStorage.clearCache();
    _totalCount = 0;
    _currentCategory = null;
    _cancelLetterLoading = true;
    await getDailyTerm();
  }

  Future<void> clearAllCache() async {
    await LocalAppStorage.clearCache();
    _totalCount = 0;
    _currentCategory = null;
    _cancelLetterLoading = true;
  }
}
