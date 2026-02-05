import 'package:hive_flutter/hive_flutter.dart';
import 'package:transly/domain/models.dart';

class LocalAppStorage {
  static const String _recentlyViewedBox = 'recently_viewed';
  static const String _recentlySearchedBox = 'recently_searched';
  static const String _favoritesBox = 'favorites';
  static const String _cachedTermsBox = 'cached_terms';
  static const String _cacheMetadataBox = 'cache_metadata';
  static const String _appSettingsBox = 'app_settings';

  static const int _maxRecentlyViewed = 2;
  static const int _maxRecentlySearched = 5;
  static const Duration _cacheExpiration = Duration(hours: 24);

  static const String _onboardingCompletedKey = 'onboarding_completed';

  // =========================================================================
  // INIT
  // =========================================================================

  static Future<void> init() async {
    await Hive.initFlutter();

    await _openBoxSafely<Map>(_recentlyViewedBox);
    // recently_searched changed from Box<String> → Box<Map>.
    // Hive doesn't throw on a generic type mismatch — it just silently
    // breaks. Delete from disk first if it exists, then open fresh.
    await _reopenBoxWithNewType<Map>(_recentlySearchedBox);
    await _openBoxSafely<Map>(_favoritesBox);
    await _openBoxSafely<Map>(_cachedTermsBox);
    await _openBoxSafely<dynamic>(_cacheMetadataBox);
    await _openBoxSafely<dynamic>(_appSettingsBox);

    // One-time migration for recently viewed (format change, same type).
    await _migrateRecentlyViewed();
  }

  static Future<void> _openBoxSafely<T>(String boxName) async {
    try {
      await Hive.openBox<T>(boxName);
    } catch (e) {
      await Hive.deleteBoxFromDisk(boxName);
      await Hive.openBox<T>(boxName);
    }
  }

  /// Use this when the generic type of a box has changed (e.g. String → Map).
  /// Hive won't throw on the mismatch — it needs to be deleted from disk
  /// and recreated. After first run the box is already Map so the delete
  /// is a no-op (box doesn't exist on disk yet when opened fresh).
  static Future<void> _reopenBoxWithNewType<T>(String boxName) async {
    try {
      // If already open from a previous call, close it first.
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
      // Delete whatever is on disk — could be old type, could be nothing.
      await Hive.deleteBoxFromDisk(boxName);
      // Open clean as the new type.
      await Hive.openBox<T>(boxName);
    } catch (e) {
      // Last resort: just try to open it.
      await Hive.openBox<T>(boxName);
    }
  }

  // =========================================================================
  // APP SETTINGS
  // =========================================================================

  static Box<dynamic> get _appSettingsBoxInstance =>
      Hive.box<dynamic>(_appSettingsBox);

  static bool isOnboardingCompleted() {
    try {
      return _appSettingsBoxInstance.get(_onboardingCompletedKey,
          defaultValue: false) as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setOnboardingCompleted() async {
    try {
      await _appSettingsBoxInstance.put(_onboardingCompletedKey, true);
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> resetOnboarding() async {
    try {
      await _appSettingsBoxInstance.delete(_onboardingCompletedKey);
    } catch (e) {
      // Ignore
    }
  }

  // =========================================================================
  // DAILY TRENDING TERMS
  // =========================================================================

  static List<TermModel>? getCachedDailyTrendingTerms() {
    try {
      final key = _dailyTrendingTermsCacheKey();
      if (!_isCacheValid(key)) return null;

      final cached = _cachedTermsBoxInstance.get(key);
      if (cached == null) return null;

      final termsList = cached['terms'] as List?;
      if (termsList == null) return null;

      return termsList
          .map((json) => TermModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e) {
      return null;
    }
  }

  static Future<void> cacheDailyTrendingTerms(List<TermModel> terms) async {
    try {
      final key = _dailyTrendingTermsCacheKey();
      await _cachedTermsBoxInstance.put(key, {
        'terms': terms.map((t) => t.toJson()).toList(),
      });
      await _setCacheTimestamp(key);
    } catch (e) {
      // Ignore
    }
  }

  static String _dailyTrendingTermsCacheKey() =>
      'daily_trending_${DateTime.now().toIso8601String().split('T')[0]}';

  // =========================================================================
  // RECENTLY VIEWED
  // Each entry: { 'term': term.toJson(), 'addedAt': microsecondsSinceEpoch }
  // Keyed by term.id.toString().
  // =========================================================================

  static Box<Map> get _recentlyViewedBoxInstance =>
      Hive.box<Map>(_recentlyViewedBox);

  /// One-time migration: old entries are bare term.toJson() with no 'addedAt'.
  /// Clear the box if any are found so the new reader doesn't choke.
  static Future<void> _migrateRecentlyViewed() async {
    try {
      final box = _recentlyViewedBoxInstance;
      if (box.isEmpty) return;

      final hasOldFormat =
          box.values.any((entry) => !entry.containsKey('addedAt'));

      if (hasOldFormat) {
        await box.clear();
      }
    } catch (e) {
      // Best-effort
    }
  }

  /// Returns terms sorted newest-first.
  static List<TermModel> getRecentlyViewed() {
    try {
      final box = _recentlyViewedBoxInstance;

      final entries = box.values
          .whereType<Map>()
          .where((e) => e.containsKey('addedAt') && e.containsKey('term'))
          .toList();

      entries.sort(
        (a, b) => (b['addedAt'] as int).compareTo(a['addedAt'] as int),
      );

      return entries
          .take(_maxRecentlyViewed)
          .map((e) => TermModel.fromJson(
                Map<String, dynamic>.from(e['term'] as Map),
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Adds or refreshes a term. A single put overwrites the old entry and
  /// stamps a new timestamp — no delete-then-put needed.
  static Future<void> addRecentlyViewed(TermModel term) async {
    try {
      final box = _recentlyViewedBoxInstance;

      await box.put(term.id.toString(), {
        'term': term.toJson(),
        'addedAt': DateTime.now().microsecondsSinceEpoch,
      });

      while (box.length > _maxRecentlyViewed) {
        _removeOldestByTimestamp(box);
      }
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> clearRecentlyViewed() async {
    try {
      await _recentlyViewedBoxInstance.clear();
    } catch (e) {
      // Ignore
    }
  }

  // =========================================================================
  // RECENTLY SEARCHED
  // Each entry: { 'query': trimmedQuery, 'addedAt': microsecondsSinceEpoch }
  // Keyed by query.toLowerCase() so duplicates overwrite cleanly.
  // =========================================================================

  static Box<Map> get _recentlySearchedBoxInstance =>
      Hive.box<Map>(_recentlySearchedBox);

  /// Returns queries sorted newest-first.
  static List<String> getRecentlySearched() {
    try {
      final box = _recentlySearchedBoxInstance;

      final entries = box.values
          .whereType<Map>()
          .where((e) => e.containsKey('addedAt') && e.containsKey('query'))
          .toList();

      entries.sort(
        (a, b) => (b['addedAt'] as int).compareTo(a['addedAt'] as int),
      );

      return entries
          .take(_maxRecentlySearched)
          .map((e) => e['query'] as String)
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Adds or refreshes a search query. Keyed by the lowercased query so
  /// re-searching the same term just bumps its timestamp.
  static Future<void> addRecentlySearched(String query) async {
    try {
      final trimmed = query.trim();
      if (trimmed.isEmpty) return;

      final box = _recentlySearchedBoxInstance;
      // Key is lowercase so "Cardio" and "cardio" map to the same slot,
      // but we store the original casing the user typed.
      final key = trimmed.toLowerCase();

      await box.put(key, {
        'query': trimmed,
        'addedAt': DateTime.now().microsecondsSinceEpoch,
      });

      while (box.length > _maxRecentlySearched) {
        _removeOldestByTimestamp(box);
      }
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> clearRecentlySearched() async {
    try {
      await _recentlySearchedBoxInstance.clear();
    } catch (e) {
      // Ignore
    }
  }

  // =========================================================================
  // SHARED HELPER — works on any box whose values have an 'addedAt' key.
  // Scans once, deletes the single entry with the smallest timestamp by key.
  // =========================================================================

  static void _removeOldestByTimestamp(Box box) {
    dynamic oldestKey;
    int? oldestTimestamp;

    for (final key in box.keys) {
      final entry = box.get(key);
      if (entry is Map && entry.containsKey('addedAt')) {
        final ts = entry['addedAt'] as int;
        if (oldestTimestamp == null || ts < oldestTimestamp) {
          oldestTimestamp = ts;
          oldestKey = key;
        }
      }
    }

    if (oldestKey != null) {
      box.delete(oldestKey);
    }
  }

  // =========================================================================
  // FAVORITES
  // =========================================================================

  static Box<Map> get _favoritesBoxInstance => Hive.box<Map>(_favoritesBox);

  static List<TermModel> getFavorites() {
    try {
      return _favoritesBoxInstance.values
          .map((json) => TermModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> addFavorite(TermModel term) async {
    try {
      await _favoritesBoxInstance.put(term.id.toString(), term.toJson());
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> removeFavorite(int termId) async {
    try {
      await _favoritesBoxInstance.delete(termId.toString());
    } catch (e) {
      // Ignore
    }
  }

  static bool isFavorite(int termId) {
    try {
      return _favoritesBoxInstance.containsKey(termId.toString());
    } catch (e) {
      return false;
    }
  }

  static Future<void> clearFavorites() async {
    try {
      await _favoritesBoxInstance.clear();
    } catch (e) {
      // Ignore
    }
  }

  // =========================================================================
  // CACHED TERMS
  // =========================================================================

  static Box<Map> get _cachedTermsBoxInstance =>
      Hive.box<Map>(_cachedTermsBox);
  static Box<dynamic> get _cacheMetadataBoxInstance =>
      Hive.box<dynamic>(_cacheMetadataBox);

  // --- Key generators -------------------------------------------------------

  static String _allTermsCacheKey(int page) => 'all_terms_page_$page';
  static String _categoryTermsCacheKey(String category) =>
      'category_$category';
  static String _searchTermsCacheKey(String query) =>
      'search_${query.toLowerCase()}';
  static String _dailyTermCacheKey() =>
      'daily_term_${DateTime.now().toIso8601String().split('T')[0]}';

  // --- Validity & timestamps ------------------------------------------------

  static bool _isCacheValid(String key) {
    try {
      final timestamp = _cacheMetadataBoxInstance.get('${key}_timestamp');
      if (timestamp == null) return false;

      final cachedTime = DateTime.parse(timestamp.toString());
      return DateTime.now().difference(cachedTime) < _cacheExpiration;
    } catch (e) {
      return false;
    }
  }

  static Future<void> _setCacheTimestamp(String key) async {
    try {
      await _cacheMetadataBoxInstance.put(
        '${key}_timestamp',
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      // Ignore
    }
  }

  // --- All terms (paginated) ------------------------------------------------

  static List<TermModel>? getCachedAllTerms(int page) {
    try {
      final key = _allTermsCacheKey(page);
      if (!_isCacheValid(key)) return null;

      final cached = _cachedTermsBoxInstance.get(key);
      if (cached == null) return null;

      final termsList = cached['terms'] as List?;
      if (termsList == null) return null;

      return termsList
          .map((json) => TermModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e) {
      return null;
    }
  }

  static Future<void> cacheAllTerms(int page, List<TermModel> terms) async {
    try {
      final key = _allTermsCacheKey(page);
      await _cachedTermsBoxInstance.put(key, {
        'terms': terms.map((t) => t.toJson()).toList(),
      });
      await _setCacheTimestamp(key);
    } catch (e) {
      // Ignore
    }
  }

  // --- Category terms --------------------------------------------------------

  static List<TermModel>? getCachedCategoryTerms(String category) {
    try {
      final key = _categoryTermsCacheKey(category);
      if (!_isCacheValid(key)) return null;

      final cached = _cachedTermsBoxInstance.get(key);
      if (cached == null) return null;

      final termsList = cached['terms'] as List?;
      if (termsList == null) return null;

      return termsList
          .map((json) => TermModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e) {
      return null;
    }
  }

  static Future<void> cacheCategoryTerms(
    String category,
    List<TermModel> terms,
  ) async {
    try {
      final key = _categoryTermsCacheKey(category);
      await _cachedTermsBoxInstance.put(key, {
        'terms': terms.map((t) => t.toJson()).toList(),
      });
      await _setCacheTimestamp(key);
    } catch (e) {
      // Ignore
    }
  }

  // --- Search results --------------------------------------------------------

  static List<TermModel>? getCachedSearchResults(String query) {
    try {
      final key = _searchTermsCacheKey(query);
      if (!_isCacheValid(key)) return null;

      final cached = _cachedTermsBoxInstance.get(key);
      if (cached == null) return null;

      final termsList = cached['terms'] as List?;
      if (termsList == null) return null;

      return termsList
          .map((json) => TermModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e) {
      return null;
    }
  }

  static Future<void> cacheSearchResults(
    String query,
    List<TermModel> terms,
  ) async {
    try {
      final key = _searchTermsCacheKey(query);
      await _cachedTermsBoxInstance.put(key, {
        'terms': terms.map((t) => t.toJson()).toList(),
      });
      await _setCacheTimestamp(key);
    } catch (e) {
      // Ignore
    }
  }

  // --- Daily term ------------------------------------------------------------

  static TermModel? getCachedDailyTerm() {
    try {
      final key = _dailyTermCacheKey();
      if (!_isCacheValid(key)) return null;

      final cached = _cachedTermsBoxInstance.get(key);
      if (cached == null) return null;

      final termData = cached['term'] as Map?;
      if (termData == null) return null;

      return TermModel.fromJson(Map<String, dynamic>.from(termData));
    } catch (e) {
      return null;
    }
  }

  static Future<void> cacheDailyTerm(TermModel term) async {
    try {
      final key = _dailyTermCacheKey();
      await _cachedTermsBoxInstance.put(key, {
        'term': term.toJson(),
      });
      await _setCacheTimestamp(key);
    } catch (e) {
      // Ignore
    }
  }

  // --- Total count -----------------------------------------------------------

  static int? getCachedTotalCount() {
    try {
      if (!_isCacheValid('total_count')) return null;
      final value = _cacheMetadataBoxInstance.get('total_count_value');
      return value is int ? value : null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> cacheTotalCount(int count) async {
    try {
      await _cacheMetadataBoxInstance.put('total_count_value', count);
      await _setCacheTimestamp('total_count');
    } catch (e) {
      // Ignore
    }
  }

  // --- Cache clearing --------------------------------------------------------

  static Future<void> clearCache() async {
    try {
      await _cachedTermsBoxInstance.clear();
      await _cacheMetadataBoxInstance.clear();
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> clearCategoryCache(String category) async {
    try {
      final key = _categoryTermsCacheKey(category);
      await _cachedTermsBoxInstance.delete(key);
      await _cacheMetadataBoxInstance.delete('${key}_timestamp');
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> clearAllTermsCache() async {
    try {
      final box = _cachedTermsBoxInstance;
      final metadata = _cacheMetadataBoxInstance;

      final keysToRemove = box.keys
          .where((key) => key.toString().startsWith('all_terms_page_'))
          .toList();

      for (final key in keysToRemove) {
        await box.delete(key);
        await metadata.delete('${key}_timestamp');
      }
    } catch (e) {
      // Ignore
    }
  }

  // =========================================================================
  // CLEAR ALL (debug / reset)
  // =========================================================================

  static Future<void> clearAllData() async {
    try {
      await _recentlyViewedBoxInstance.clear();
      await _recentlySearchedBoxInstance.clear();
      await _favoritesBoxInstance.clear();
      await _cachedTermsBoxInstance.clear();
      await _cacheMetadataBoxInstance.clear();
      await _appSettingsBoxInstance.clear();
    } catch (e) {
      // Ignore
    }
  }
}