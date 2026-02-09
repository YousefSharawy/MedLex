import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transly/app/local_storage.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/domain/repository.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final Repository _repository;

  bool _isSearching = false;
  List<TermModel>? _searchResults;
  bool _isSearchLoading = false;
  String? _searchError;
  String? _pendingSearchText;

  // Recently Searched
  List<String> _recentlySearched = [];

  SearchCubit(this._repository) : super(const SearchState.initial()) {
    _recentlySearched = LocalAppStorage.getRecentlySearched();
  }

  /// Safe emit that checks if cubit is still open
  void _safeEmit(SearchState state) {
    if (!isClosed) emit(state);
  }

  // ==================== GETTERS ====================

  bool get isSearching => _isSearching;
  String? get pendingSearchText => _pendingSearchText;
  List<String> get recentlySearched => _recentlySearched;

  // ==================== SEARCH STATE ====================

  void setSearching(bool value) {
    _isSearching = value;
    if (!value) {
      _searchResults = null;
      _isSearchLoading = false;
      _searchError = null;
      _pendingSearchText = null;
    }
    _emitSearchState();
  }

  void setSearchTextAndActivate(String text) {
    _pendingSearchText = text;
    _isSearching = true;
    _emitSearchState();
    searchTerms(text);
  }

  void clearPendingSearchText() {
    _pendingSearchText = null;
  }

  void resetSearchState() {
    _isSearching = false;
    _searchResults = null;
    _isSearchLoading = false;
    _searchError = null;
    _emitSearchState();
  }

  void _emitSearchState() {
    _safeEmit(
      SearchState.loaded(
        isSearching: _isSearching,
        searchResults:
            _searchResults != null ? List.from(_searchResults!) : null,
        isSearchLoading: _isSearchLoading,
        searchError: _searchError,
        recentlySearched: List.from(_recentlySearched),
        pendingSearchText: _pendingSearchText,
      ),
    );
  }

  // ==================== SEARCH ====================

  Future<void> searchTerms(String query) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      _searchResults = [];
      _isSearchLoading = false;
      _searchError = null;
      _emitSearchState();
      return;
    }

    await addToRecentlySearched(trimmedQuery);
    if (isClosed) return;

    final cachedResults = LocalAppStorage.getCachedSearchResults(trimmedQuery);
    if (cachedResults != null) {
      _searchResults = cachedResults;
      _isSearchLoading = false;
      _searchError = null;
      _emitSearchState();
      return;
    }

    _isSearchLoading = true;
    _searchError = null;
    _emitSearchState();

    final result = await _repository.searchTerms(trimmedQuery);
    if (isClosed) return;

    final terms = result.fold<List<TermModel>?>(
      (failure) {
        _searchError = failure.message;
        return null;
      },
      (terms) => terms,
    );

    if (terms != null) {
      _searchResults = terms;
      _isSearchLoading = false;
      _searchError = null;
      await LocalAppStorage.cacheSearchResults(trimmedQuery, terms);
    } else {
      _searchResults = null;
      _isSearchLoading = false;
    }

    _emitSearchState();
  }

  void clearSearchResults() {
    _searchResults = null;
    _isSearchLoading = false;
    _searchError = null;
    _emitSearchState();
  }

  // ==================== RECENTLY SEARCHED ====================

  Future<void> addToRecentlySearched(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;

    await LocalAppStorage.addRecentlySearched(trimmedQuery);
    _recentlySearched = List.from(LocalAppStorage.getRecentlySearched());
    _emitSearchState();
  }

  Future<void> clearRecentlySearched() async {
    await LocalAppStorage.clearRecentlySearched();
    _recentlySearched = [];
    _emitSearchState();
  }
}