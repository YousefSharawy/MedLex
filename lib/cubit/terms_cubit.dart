import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medlex/app/local_storage.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/domain/repository.dart';
part 'terms_state.dart';
part 'terms_cubit.freezed.dart';

/// Browsing the term catalogue: paginated "all terms", the A-Z letter-jump
/// over that pagination, and per-category term lists.
///
/// Favorites and recently-viewed are separate concerns with their own
/// cubits ([FavoritesCubit], [RecentlyViewedCubit]) — they used to share this
/// state, which meant an unrelated favorite toggle could clobber an
/// in-progress letter-jump's state and silently abort it.
class TermsCubit extends Cubit<TermsState> {
  final Repository _repository;

  String? _currentCategory;
  bool _isLoadingTerms = false;
  bool _cancelLetterLoading = false;
  int _totalCount = 0;

  // FIX: class-level field so the guard actually works across calls
  int _categoryRequestToken = 0;

  static const int _pageSize = 30;
  static const int _maxLetterLoadIterations = 50;

  /// Sentinel for "the catalogue size is not known" — the count request failed
  /// and no cached value was available.
  static const int _unknownTotalCount = 0;

  TermsCubit(this._repository) : super(const TermsState.initial());

  void _safeEmit(TermsState state) {
    if (!isClosed) emit(state);
  }

  // ==================== GETTERS ====================

  String? get currentCategory => _currentCategory;

  AllTermsLoaded? get _allTermsState {
    final s = state;
    return s is AllTermsLoaded ? s : null;
  }

  String? get pendingLetter => _allTermsState?.pendingLetter;

  // ==================== HELPER METHODS ====================

  /// The catalogue size, or [_unknownTotalCount] when we could not obtain it.
  ///
  /// A failed count must not be reported as zero: `hasMore` is derived from it,
  /// and zero reads as "everything is already loaded", which silently disables
  /// pagination for the rest of the session.
  Future<int> _getTotalCount() async {
    if (_totalCount > 0) return _totalCount;

    final cachedCount = LocalAppStorage.getCachedTotalCount();
    if (cachedCount != null && cachedCount > 0) {
      _totalCount = cachedCount;
      return _totalCount;
    }

    final countResult = await _repository.getTotalTermsCount();
    final count = countResult.fold<int?>((failure) => null, (count) => count);

    if (count != null) {
      _totalCount = count;
      LocalAppStorage.cacheTotalCount(count);
    }

    return _totalCount;
  }

  /// Whether more pages are worth requesting.
  ///
  /// With a known total this is simply "we have fewer than all of them". When
  /// the count request failed we fall back to "the last page came back full",
  /// so a user who opened the app offline can still page through the terms
  /// they have cached instead of being pinned to the first page.
  bool _hasMoreTerms({
    required int loadedCount,
    required int totalCount,
    required int lastPageLength,
  }) {
    if (totalCount > _unknownTotalCount) return loadedCount < totalCount;
    return lastPageLength >= _pageSize;
  }

  String _getFirstLetter(String term) {
    if (term.isEmpty) return '#';
    final firstChar = term[0].toUpperCase();
    return RegExp(r'^[A-Z]$').hasMatch(firstChar) ? firstChar : '#';
  }

  Map<String, List<TermModel>> _groupTermsByLetter(List<TermModel> terms) {
    final Map<String, List<TermModel>> grouped = {};
    for (final term in terms) {
      final letter = _getFirstLetter(term.latinTerm);
      grouped.putIfAbsent(letter, () => []).add(term);
    }
    for (final list in grouped.values) {
      list.sort((a, b) => a.latinTerm.compareTo(b.latinTerm));
    }
    return grouped;
  }

  bool _termsContainLetter(List<TermModel> terms, String letter) {
    return terms.any((term) => _getFirstLetter(term.latinTerm) == letter);
  }

  bool isLetterAvailable(String letter) {
    final currentState = _allTermsState;
    if (currentState == null) return false;
    return _termsContainLetter(currentState.terms, letter);
  }

  // ==================== ALL TERMS (PAGINATED) ====================

  void _emitAllTermsLoaded({
    required List<TermModel> terms,
    required int currentPage,
    required int totalCount,
    required int lastPageLength,
    bool isLoadingMore = false,
    String? pendingLetter,
    String? letterJustLoaded,
  }) {
    final hasMore = _hasMoreTerms(
      loadedCount: terms.length,
      totalCount: totalCount,
      lastPageLength: lastPageLength,
    );
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

  Future<void> getAllTerms({bool refresh = false}) async {
    _currentCategory = 'All';
    _cancelLetterLoading = true;

    final totalCount = await _getTotalCount();
    if (isClosed) return;

    if (!refresh) {
      final cachedTerms = LocalAppStorage.getCachedAllTerms(0);
      if (cachedTerms != null && cachedTerms.isNotEmpty) {
        _emitAllTermsLoaded(
          terms: cachedTerms,
          currentPage: 0,
          totalCount: totalCount,
          lastPageLength: cachedTerms.length,
        );
        return;
      }
    }

    _safeEmit(const TermsState.allTermsLoading());

    final result = await _repository.getAllTerms(page: 0, pageSize: _pageSize);
    if (isClosed) return;

    final terms = result.fold<List<TermModel>?>((failure) {
      _safeEmit(TermsState.allTermsError(failure.message));
      return null;
    }, (terms) => terms);

    if (terms != null) {
      await LocalAppStorage.cacheAllTerms(0, terms);
      if (isClosed) return;
      _emitAllTermsLoaded(
        terms: terms,
        currentPage: 0,
        totalCount: totalCount,
        lastPageLength: terms.length,
      );
    }
  }

  Future<void> loadMoreTerms() async {
    final currentState = _allTermsState;
    if (currentState == null) return;
    if (!currentState.hasMore) return;
    if (_isLoadingTerms) return;

    _isLoadingTerms = true;
    try {
      _safeEmit(currentState.copyWith(isLoadingMore: true));

      final nextPage = currentState.currentPage + 1;
      final cachedTerms = LocalAppStorage.getCachedAllTerms(nextPage);

      if (cachedTerms != null && cachedTerms.isNotEmpty) {
        final allTerms = [...currentState.terms, ...cachedTerms];
        _emitAllTermsLoaded(
          terms: allTerms,
          currentPage: nextPage,
          totalCount: currentState.totalCount,
          lastPageLength: cachedTerms.length,
        );
        return;
      }

      final result = await _repository.getAllTerms(
        page: nextPage,
        pageSize: _pageSize,
      );
      if (isClosed) return;

      final terms = result.fold<List<TermModel>?>((failure) => null, (t) => t);

      if (terms != null) {
        await LocalAppStorage.cacheAllTerms(nextPage, terms);
        if (isClosed) return;
        final allTerms = [...currentState.terms, ...terms];
        _emitAllTermsLoaded(
          terms: allTerms,
          currentPage: nextPage,
          totalCount: currentState.totalCount,
          lastPageLength: terms.length,
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
        final s = _allTermsState;
        if (s != null) _safeEmit(s.copyWith(pendingLetter: null));
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
        int lastPageLength = _pageSize;

        while (!_cancelLetterLoading && !isClosed && hasMore && !letterFound) {
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

            newTerms = result.fold<List<TermModel>?>((failure) {
              _cancelLetterLoading = true;
              return null;
            }, (terms) => terms);

            if (newTerms != null) {
              await LocalAppStorage.cacheAllTerms(page, newTerms);
              if (isClosed) return;
            }
          }

          if (_cancelLetterLoading || isClosed || newTerms == null) break;

          accumulatedTerms.addAll(newTerms);
          lastPageLength = newTerms.length;
          hasMore = _hasMoreTerms(
            loadedCount: accumulatedTerms.length,
            totalCount: currentState.totalCount,
            lastPageLength: lastPageLength,
          );
          letterFound = _termsContainLetter(newTerms, letter);
        }

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
          lastPageLength: lastPageLength,
          pendingLetter: letterFound ? null : (hasMore ? letter : null),
          letterJustLoaded: letterFound ? letter : null,
        );

        if (letterFound || !hasMore) return;
      } finally {
        _isLoadingTerms = false;
      }
    }

    if (!isClosed) {
      final s = _allTermsState;
      if (s != null && s.pendingLetter != null) {
        _safeEmit(s.copyWith(pendingLetter: null));
      }
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
    // FIX: Cancel any in-flight letter loading for the previous category
    _cancelLetterLoading = true;

    // FIX: Increment the class-level token — stale responses will see a
    // mismatch and discard their result
    final myToken = ++_categoryRequestToken;

    // An empty cached list is not a usable result — a category the backend
    // briefly reported as empty would otherwise stay blank until the entry
    // expires, with no request ever made. Fall through and refetch instead.
    final cachedTerms = LocalAppStorage.getCachedCategoryTerms(category);
    if (cachedTerms != null && cachedTerms.isNotEmpty) {
      if (_categoryRequestToken == myToken) {
        _safeEmit(TermsState.termsByCategoryLoaded(cachedTerms));
      }
      return;
    }

    _safeEmit(const TermsState.termsByCategoryLoading());

    final result = await _repository.getTermsByCategory(category);
    if (isClosed) return;

    // FIX: Token check now actually works — stale requests are discarded
    if (_categoryRequestToken != myToken) return;

    final terms = result.fold<List<TermModel>?>((failure) {
      _safeEmit(TermsState.termsByCategoryError(failure.message));
      return null;
    }, (terms) => terms);

    if (terms != null) {
      await LocalAppStorage.cacheCategoryTerms(category, terms);
      if (isClosed) return;
      if (_categoryRequestToken == myToken) {
        _safeEmit(TermsState.termsByCategoryLoaded(terms));
      }
    }
  }

  // ==================== CLOSE ====================

  @override
  Future<void> close() {
    _cancelLetterLoading = true;
    return super.close();
  }
}
