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
  
  // All Terms (Paginated)
  List<TermModel> _allTerms = [];
  int _currentPage = 0;
  bool _hasMore = true;
  int _totalCount = 0;
  static const int _pageSize = 30;
  
  // Category State Tracking
  String? _currentCategory;
  
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
        searchResults: _searchResults != null ? List.from(_searchResults!) : null,
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
    // Try cache first
    final cachedTrending = LocalAppStorage.getCachedDailyTrendingTerms();
    if (cachedTrending != null && cachedTrending.isNotEmpty) {
      _trendingTerms = cachedTrending;
      _emitHomeState();
      return;
    }

    // Get total count to know database size
    int totalCount = _totalCount;
    if (totalCount == 0) {
      final countResult = await _repository.getTotalTermsCount();
      await countResult.fold((failure) async => null, (count) async {
        totalCount = count;
        _totalCount = count;
        await LocalAppStorage.cacheTotalCount(count);
      });
    }

    if (totalCount == 0) return;

    // Calculate a random starting page using daily seed
    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;
    final random = Random(seed);

    // Get a random offset in the database
    final totalPages = (totalCount / 30).ceil();
    final randomPage = random.nextInt(
      totalPages.clamp(0, totalPages - 3),
    ); // Leave room to get multiple pages

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
      // Filter out popular terms
      final availableTerms = allTerms.where((term) {
        return !_popularTerms.any((popular) => popular.id == term.id);
      }).toList();

      // Get 5 random terms from this set
      _trendingTerms = _getDailyRandomTerms(availableTerms, 5);

      await LocalAppStorage.cacheDailyTrendingTerms(_trendingTerms);
      _emitHomeState();
    }
  }

  // ==================== POPULAR TERMS ====================

  Future<void> loadPopularTerms() async {
    int totalCount = _totalCount;
    if (totalCount == 0) {
      final countResult = await _repository.getTotalTermsCount();
      await countResult.fold((failure) async => null, (count) async {
        totalCount = count;
        _totalCount = count;
        await LocalAppStorage.cacheTotalCount(count);
      });
    }

    if (totalCount == 0) return;

    // Calculate a random starting page using daily seed for popular terms
    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;

    // Use a different offset for popular terms (add 12345 to seed for variation)
    final popularSeed = Random(seed + 12345);
    final totalPages = (totalCount / 30).ceil();
    final randomPage = popularSeed.nextInt(totalPages.clamp(0, totalPages - 2));

    // Fetch terms from random position
    List<TermModel> termsForSelection = [];

    // Try to get from 2 consecutive pages for variety
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

      // Load trending terms AFTER popular terms are set
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
    // Trim the query before adding
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      return;
    }

    await LocalAppStorage.addRecentlySearched(trimmedQuery);
    // Force a new list instance to trigger rebuild
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

    // Try cache first
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
        // Cache the daily term
        await LocalAppStorage.cacheDailyTerm(term);
        _emitHomeState();
      },
    );

    // Also load popular terms
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

    // FIRST: Add to recently searched (this will trigger a state update)
    await addToRecentlySearched(trimmedQuery);

    // Try cache first
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
        // Cache search results
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

  // ==================== ALL TERMS (PAGINATED) ====================

  Future<void> getAllTerms({bool refresh = false}) async {
    // Track current category
    _currentCategory = 'All';
    
    if (refresh) {
      _allTerms = [];
      _currentPage = 0;
      _hasMore = true;
    }

    // Get total count (try cache first)
    if (_totalCount == 0) {
      final cachedCount = LocalAppStorage.getCachedTotalCount();
      if (cachedCount != null) {
        _totalCount = cachedCount;
      } else {
        final countResult = await _repository.getTotalTermsCount();
        countResult.fold((failure) => null, (count) async {
          _totalCount = count;
          await LocalAppStorage.cacheTotalCount(count);
        });
      }
    }

    // Try cache first for page 0
    if (!refresh) {
      final cachedTerms = LocalAppStorage.getCachedAllTerms(0);
      if (cachedTerms != null && cachedTerms.isNotEmpty) {
        _allTerms = cachedTerms;
        _currentPage = 0;
        _hasMore = cachedTerms.length >= _pageSize && _allTerms.length < _totalCount;
        emit(
          AppState.allTermsLoaded(
            terms: _allTerms,
            hasMore: _hasMore,
            currentPage: _currentPage,
          ),
        );
        return;
      }
    }

    emit(const AppState.allTermsLoading());

    final result = await _repository.getAllTerms(page: 0, pageSize: _pageSize);

    result.fold(
      (failure) => emit(AppState.allTermsError(failure.message)),
      (terms) async {
        _allTerms = terms;
        _currentPage = 0;
        _hasMore = terms.length >= _pageSize && _allTerms.length < _totalCount;
        // Cache the results
        await LocalAppStorage.cacheAllTerms(0, terms);
        emit(
          AppState.allTermsLoaded(
            terms: _allTerms,
            hasMore: _hasMore,
            currentPage: _currentPage,
          ),
        );
      },
    );
  }

  Future<void> loadMoreTerms() async {
    final currentState = state;
    if (currentState is! AllTermsLoaded || !_hasMore) return;
    if (currentState.isLoadingMore) return;

    emit(
      AppState.allTermsLoaded(
        terms: _allTerms,
        hasMore: _hasMore,
        currentPage: _currentPage,
        isLoadingMore: true,
      ),
    );

    final nextPage = _currentPage + 1;

    // Try cache first
    final cachedTerms = LocalAppStorage.getCachedAllTerms(nextPage);
    if (cachedTerms != null && cachedTerms.isNotEmpty) {
      _allTerms.addAll(cachedTerms);
      _currentPage = nextPage;
      _hasMore = cachedTerms.length >= _pageSize && _allTerms.length < _totalCount;
      emit(
        AppState.allTermsLoaded(
          terms: List.from(_allTerms),
          hasMore: _hasMore,
          currentPage: _currentPage,
          isLoadingMore: false,
        ),
      );
      return;
    }

    final result = await _repository.getAllTerms(
      page: nextPage,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) {
        emit(
          AppState.allTermsLoaded(
            terms: _allTerms,
            hasMore: _hasMore,
            currentPage: _currentPage,
            isLoadingMore: false,
          ),
        );
      },
      (terms) async {
        _allTerms.addAll(terms);
        _currentPage = nextPage;
        _hasMore = terms.length >= _pageSize && _allTerms.length < _totalCount;
        // Cache the results
        await LocalAppStorage.cacheAllTerms(nextPage, terms);
        emit(
          AppState.allTermsLoaded(
            terms: List.from(_allTerms),
            hasMore: _hasMore,
            currentPage: _currentPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  // ==================== CATEGORY ====================

  Future<void> getTermsByCategory(String category) async {
    // Track current category
    _currentCategory = category;
    
    // Try cache first
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
        // Cache the results
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
    await getDailyTerm();
  }

  Future<void> clearAllCache() async {
    await LocalAppStorage.clearCache();
    _totalCount = 0;
    _currentCategory = null;
  }
}