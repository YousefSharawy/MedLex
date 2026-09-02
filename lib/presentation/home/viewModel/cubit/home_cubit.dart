import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medlex/app/local_storage.dart';
import 'package:medlex/domain/models.dart';
import 'package:medlex/domain/repository.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final Repository _repository;

  TermModel? _dailyTerm;

  // Popular & Trending
  List<TermModel> _popularTerms = [];
  List<TermModel> _trendingTerms = [];

  // Total count (shared across features)
  int _totalCount = 0;

  HomeCubit(this._repository) : super(const HomeState.initial());

  /// Safe emit that checks if cubit is still open
  void _safeEmit(HomeState state) {
    if (!isClosed) emit(state);
  }

  // ==================== GETTERS ====================

  TermModel? get dailyTerm => _dailyTerm;
  List<TermModel> get popularTerms => _popularTerms;
  List<TermModel> get trendingTerms => _trendingTerms;
  int get totalCount => _totalCount;

  // ==================== EMIT HOME STATE ====================

  void emitHomeState({bool isLoading = false, String? errorMessage}) {
    _safeEmit(
      HomeState.loaded(
        dailyTerm: _dailyTerm,
        isLoading: isLoading,
        errorMessage: errorMessage,
        popularTerms: List.from(_popularTerms),
        trendingTerms: List.from(_trendingTerms),
      ),
    );
  }

  // ==================== TRENDING TERMS ====================

  Future<void> loadTrendingTerms() async {
    final cachedTrending = LocalAppStorage.getCachedDailyTrendingTerms();
    if (cachedTrending != null && cachedTrending.isNotEmpty) {
      _trendingTerms = cachedTrending;
      emitHomeState();
      return;
    }

    int totalCount = await _getTotalCount();
    if (totalCount == 0 || isClosed) return;

    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;
    final random = Random(seed);

    final totalPages = (totalCount / 30).ceil();
    final randomPage =
        random.nextInt(totalPages.clamp(1, totalPages - 3).toInt());

    final List<TermModel> allTerms = [];
    for (int i = 0; i < 4; i++) {
      if (isClosed) return;

      final result = await _repository.getAllTerms(
        page: randomPage + i,
        pageSize: 30,
      );

      final terms = result.fold<List<TermModel>?>(
        (failure) => null,
        (terms) => terms,
      );

      if (terms != null) {
        allTerms.addAll(terms);
      }
    }

    if (isClosed) return;

    if (allTerms.isNotEmpty) {
      final availableTerms = allTerms.where((term) {
        return !_popularTerms.any((popular) => popular.id == term.id);
      }).toList();

      _trendingTerms = _getDailyRandomTerms(availableTerms, 5);

      await LocalAppStorage.cacheDailyTrendingTerms(_trendingTerms);
      emitHomeState();
    }
  }

  // ==================== POPULAR TERMS ====================

  Future<void> loadPopularTerms() async {
    int totalCount = await _getTotalCount();
    if (totalCount == 0 || isClosed) return;

    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;

    final popularSeed = Random(seed + 12345);
    final totalPages = (totalCount / 30).ceil();
    final randomPage =
        popularSeed.nextInt(totalPages.clamp(1, totalPages - 2).toInt());

    List<TermModel> termsForSelection = [];

    for (int i = 0; i < 2; i++) {
      if (isClosed) return;

      final result = await _repository.getAllTerms(
        page: randomPage + i,
        pageSize: 30,
      );

      final terms = result.fold<List<TermModel>?>(
        (failure) => null,
        (terms) => terms,
      );

      if (terms != null) {
        termsForSelection.addAll(terms);
      }
    }

    if (isClosed) return;

    if (termsForSelection.isNotEmpty) {
      _popularTerms = _getDailyRandomTerms(termsForSelection, 4);
      emitHomeState();

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

  // ==================== DAILY TERM ====================

  Future<void> getDailyTerm() async {
    emitHomeState(isLoading: true);

    final cachedDailyTerm = LocalAppStorage.getCachedDailyTerm();
    if (cachedDailyTerm != null) {
      _dailyTerm = cachedDailyTerm;
      emitHomeState();
      await loadPopularTerms();
      return;
    }

    final result = await _repository.getDailyTerm();
    if (isClosed) return;

    result.fold(
      (failure) {
        _dailyTerm = null;
        emitHomeState(errorMessage: failure.message);
      },
      (term) {
        _dailyTerm = term;
        LocalAppStorage.cacheDailyTerm(term);
        emitHomeState();
      },
    );

    await loadPopularTerms();
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

  // ==================== CACHE MANAGEMENT ====================

  Future<void> refreshAllData() async {
    await LocalAppStorage.clearCache();
    _totalCount = 0;
    await getDailyTerm();
  }

  Future<void> clearAllCache() async {
    await LocalAppStorage.clearCache();
    _totalCount = 0;
  }
}