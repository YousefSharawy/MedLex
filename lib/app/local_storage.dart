import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medlex/domain/models.dart';

class LocalAppStorage {
  static const String _recentlyViewedBox = 'recently_viewed';
  static const String _recentlyViewedHistoryBox = 'full_recently_viewed';
  static const String _recentlySearchedBox = 'recently_searched';
  static const String _favoritesBox = 'favorites';
  static const String _cachedTermsBox = 'cached_terms';
  static const String _cacheMetadataBox = 'cache_metadata';
  static const String _appSettingsBox = 'app_settings';

  static const int _maxRecentlyViewed = 2;
  /// The Recently Viewed screen shows the full history; without a cap this box
  /// grows one serialized term per distinct term opened, forever, and is
  /// deserialized and sorted in full on every read.
  static const int _maxRecentlyViewedHistory = 100;
  static const int _maxRecentlySearched = 5;
  static const Duration _cacheExpiration = Duration(hours: 24);

  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _totalCountKey = 'total_count';

  // =========================================================================
  // INIT
  // =========================================================================

  static Future<void> init() async {
    await Hive.initFlutter();
    await _openBoxSafely<Map>(_recentlyViewedBox);
    await _openBoxSafely<Map>(_recentlyViewedHistoryBox);
    await _openBoxSafely<Map>(_recentlySearchedBox);
    await _openBoxSafely<Map>(_favoritesBox);
    await _openBoxSafely<Map>(_cachedTermsBox);
    await _openBoxSafely<dynamic>(_cacheMetadataBox);
    await _openBoxSafely<dynamic>(_appSettingsBox);
    await _openBoxSafely<Map>(_weakWordsBox);
    await _migrateRecentlyViewed();
  }

  /// Opens [boxName], recreating it only when Hive reports the stored data is
  /// genuinely unreadable.
  ///
  /// Hive raises [HiveError] for wrong checksums and for a value type that no
  /// longer matches what was written. Those are unrecoverable, so recreating
  /// the box is the only way forward — and that also performs the one-time
  /// migration for any box whose type we have since changed.
  ///
  /// Every other failure (file lock, low disk, slow filesystem) is transient
  /// and must never cost the user their data, so we retry once and otherwise
  /// leave the box closed. The accessors below already degrade to empty when a
  /// box is missing, so the app runs read-only-empty for this session and the
  /// next launch picks the on-disk data back up. That beats both deleting it
  /// and throwing, since `main()` does not guard the `init()` call.
  static Future<void> _openBoxSafely<T>(String boxName) async {
    try {
      await Hive.openBox<T>(boxName);
      return;
    } on HiveError catch (error) {
      _reportBestEffortFailure('_openBoxSafely($boxName) recreating', error);
      try {
        await Hive.deleteBoxFromDisk(boxName);
      } catch (deleteError) {
        _reportBestEffortFailure('_openBoxSafely($boxName) delete', deleteError);
      }
    } catch (error) {
      // Transient — fall through to the retry without touching the file.
      _reportBestEffortFailure('_openBoxSafely($boxName) transient', error);
    }

    try {
      await Hive.openBox<T>(boxName);
    } catch (error) {
      _reportBestEffortFailure('_openBoxSafely($boxName) retry', error);
    }
  }

  /// Records a failure on a path that is deliberately best-effort.
  ///
  /// Caches and browsing history are optimisations: losing a write costs the
  /// user nothing they created, so these must not fail a user action. They must
  /// still be visible to us though — silence here is what turns a broken box
  /// into "the feature just doesn't work" with nothing to go on.
  ///
  /// Anything the user actually authored (their favorites) does NOT come
  /// through here; those writes propagate so the caller can react.
  static void _reportBestEffortFailure(String operation, Object error) {
    debugPrint('LocalAppStorage.$operation failed: $error');
  }

  // =========================================================================
  // BOX ACCESSORS
  // =========================================================================

  static Box<Map> get _recentlyViewedBoxInstance =>
      Hive.box<Map>(_recentlyViewedBox);
  static Box<Map> get _recentlyViewedHistoryBoxInstance =>
      Hive.box<Map>(_recentlyViewedHistoryBox);
  static Box<Map> get _recentlySearchedBoxInstance =>
      Hive.box<Map>(_recentlySearchedBox);
  static Box<Map> get _favoritesBoxInstance => Hive.box<Map>(_favoritesBox);
  static Box<Map> get _cachedTermsBoxInstance =>
      Hive.box<Map>(_cachedTermsBox);
  static Box<dynamic> get _cacheMetadataBoxInstance =>
      Hive.box<dynamic>(_cacheMetadataBox);
  static Box<dynamic> get _appSettingsBoxInstance =>
      Hive.box<dynamic>(_appSettingsBox);

  // =========================================================================
  // APP SETTINGS
  // =========================================================================

  static bool isOnboardingCompleted() {
    try {
      return _appSettingsBoxInstance.get(
        _onboardingCompletedKey,
        defaultValue: false,
      ) as bool;
    } catch (error) {
      _reportBestEffortFailure('isOnboardingCompleted', error);
      return false;
    }
  }

  static Future<void> setOnboardingCompleted() async {
    try {
      await _appSettingsBoxInstance.put(_onboardingCompletedKey, true);
    } catch (error) {
      _reportBestEffortFailure('setOnboardingCompleted', error);
    }
  }

  static Future<void> resetOnboarding() async {
    try {
      await _appSettingsBoxInstance.delete(_onboardingCompletedKey);
    } catch (error) {
      _reportBestEffortFailure('resetOnboarding', error);
    }
  }

  // =========================================================================
  // CACHE HELPERS — single implementation, used everywhere
  // =========================================================================

  static bool _isCacheValid(String key) {
    try {
      final timestamp = _cacheMetadataBoxInstance.get('${key}_timestamp');
      if (timestamp == null) return false;
      final cachedTime = DateTime.parse(timestamp.toString());
      return DateTime.now().difference(cachedTime) < _cacheExpiration;
    } catch (error) {
      _reportBestEffortFailure('_isCacheValid', error);
      return false;
    }
  }

  static Future<void> _setCacheTimestamp(String key) async {
    try {
      await _cacheMetadataBoxInstance.put(
        '${key}_timestamp',
        DateTime.now().toIso8601String(),
      );
    } catch (error) {
      _reportBestEffortFailure('_setCacheTimestamp', error);
    }
  }

  static Future<void> _deleteCacheEntry(String key) async {
    try {
      await _cachedTermsBoxInstance.delete(key);
      await _cacheMetadataBoxInstance.delete('${key}_timestamp');
    } catch (error) {
      _reportBestEffortFailure('_deleteCacheEntry', error);
    }
  }

  /// Generic: read a list of TermModel from the cache box under [key].
  static List<TermModel>? _readTermsList(String key) {
    try {
      if (!_isCacheValid(key)) return null;
      final cached = _cachedTermsBoxInstance.get(key);
      final termsList = cached?['terms'] as List?;
      if (termsList == null) return null;
      return termsList
          .map((j) => TermModel.fromJson(Map<String, dynamic>.from(j as Map)))
          .toList();
    } catch (error) {
      _reportBestEffortFailure('_readTermsList', error);
      return null;
    }
  }

  /// Generic: write a list of TermModel to the cache box under [key].
  static Future<void> _writeTermsList(
      String key, List<TermModel> terms) async {
    try {
      await _cachedTermsBoxInstance.put(key, {
        'terms': terms.map((t) => t.toJson()).toList(),
      });
      await _setCacheTimestamp(key);
    } catch (error) {
      _reportBestEffortFailure('_writeTermsList', error);
    }
  }

  // =========================================================================
  // KEY GENERATORS
  // =========================================================================

  static String _allTermsCacheKey(int page) => 'all_terms_page_$page';

  static String _categoryTermsCacheKey(String category) {
    final sanitized = category
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('&', 'and')
        .replaceAll('-', '_')
        .replaceAll('/', '_');
    return 'category_$sanitized';
  }

  static String _searchTermsCacheKey(String query) =>
      'search_${query.toLowerCase()}';

  static String _dailyTermCacheKey() =>
      'daily_term_${DateTime.now().toIso8601String().split('T')[0]}';

  static String _dailyTrendingTermsCacheKey() =>
      'daily_trending_${DateTime.now().toIso8601String().split('T')[0]}';

  // =========================================================================
  // RECENTLY VIEWED
  // =========================================================================

  static Future<void> _migrateRecentlyViewed() async {
    try {
      final box = _recentlyViewedBoxInstance;
      if (box.isEmpty) return;
      if (box.values.any((e) => !e.containsKey('addedAt'))) {
        await box.clear();
      }
    } catch (error) {
      _reportBestEffortFailure('_migrateRecentlyViewed', error);
    }
  }

  static List<TermModel> getRecentlyViewed() {
    try {
      final entries = _recentlyViewedBoxInstance.values
          .whereType<Map>()
          .where((e) => e.containsKey('addedAt') && e.containsKey('term'))
          .toList()
        ..sort((a, b) =>
            (b['addedAt'] as int).compareTo(a['addedAt'] as int));

      return entries
          .take(_maxRecentlyViewed)
          .map((e) =>
              TermModel.fromJson(Map<String, dynamic>.from(e['term'] as Map)))
          .toList();
    } catch (error) {
      _reportBestEffortFailure('getRecentlyViewed', error);
      return [];
    }
  }
  static List<TermModel> getRecentlyViewedHistory() {
    try {
      final entries = _recentlyViewedHistoryBoxInstance.values
          .whereType<Map>()
          .where((e) => e.containsKey('addedAt') && e.containsKey('term'))
          .toList()
        ..sort((a, b) =>
            (b['addedAt'] as int).compareTo(a['addedAt'] as int));

      return entries
          .map((e) =>
              TermModel.fromJson(Map<String, dynamic>.from(e['term'] as Map)))
          .toList();
    } catch (error) {
      _reportBestEffortFailure('getRecentlyViewedHistory', error);
      return [];
    }
  }

  static Future<void> addRecentlyViewed(TermModel term) async {
    try {
      final box = _recentlyViewedBoxInstance;
      await box.put(term.id.toString(), {
        'term': term.toJson(),
        'addedAt': DateTime.now().microsecondsSinceEpoch,
      });
      while (box.length > _maxRecentlyViewed) {
        await _removeOldestByTimestamp(box);
      }
    } catch (error) {
      _reportBestEffortFailure('addRecentlyViewed', error);
    }
  }
  static Future<void> addRecentlyViewedHistory(TermModel term) async {
    try {
      final box = _recentlyViewedHistoryBoxInstance;
      await box.put(term.id.toString(), {
        'term': term.toJson(),
        'addedAt': DateTime.now().microsecondsSinceEpoch,
      });
      while (box.length > _maxRecentlyViewedHistory) {
        await _removeOldestByTimestamp(box);
      }
    } catch (error) {
      _reportBestEffortFailure('addRecentlyViewedHistory', error);
    }
  }

  static Future<void> clearRecentlyViewed() async {
    try {
      await _recentlyViewedBoxInstance.clear();
      await _recentlyViewedHistoryBoxInstance.clear();
    } catch (error) {
      _reportBestEffortFailure('clearRecentlyViewed', error);
    }
  }

  // =========================================================================
  // RECENTLY SEARCHED
  // =========================================================================

  static List<String> getRecentlySearched() {
    try {
      final entries = _recentlySearchedBoxInstance.values
          .whereType<Map>()
          .where((e) => e.containsKey('addedAt') && e.containsKey('query'))
          .toList()
        ..sort((a, b) =>
            (b['addedAt'] as int).compareTo(a['addedAt'] as int));

      return entries
          .take(_maxRecentlySearched)
          .map((e) => e['query'] as String)
          .toList();
    } catch (error) {
      _reportBestEffortFailure('getRecentlySearched', error);
      return [];
    }
  }

  static Future<void> addRecentlySearched(String query) async {
    try {
      final trimmed = query.trim();
      if (trimmed.isEmpty) return;
      final box = _recentlySearchedBoxInstance;
      await box.put(trimmed.toLowerCase(), {
        'query': trimmed,
        'addedAt': DateTime.now().microsecondsSinceEpoch,
      });
      while (box.length > _maxRecentlySearched) {
        await _removeOldestByTimestamp(box);
      }
    } catch (error) {
      _reportBestEffortFailure('addRecentlySearched', error);
    }
  }

  static Future<void> clearRecentlySearched() async {
    try {
      await _recentlySearchedBoxInstance.clear();
    } catch (error) {
      _reportBestEffortFailure('clearRecentlySearched', error);
    }
  }

  // =========================================================================
  // SHARED HELPER
  // =========================================================================

  // FIX: was void but called box.delete() which returns a Future —
  // now properly async so the caller's while-loop actually waits
  static Future<void> _removeOldestByTimestamp(Box box) async {
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

    if (oldestKey != null) await box.delete(oldestKey);
  }
  // =========================================================================
  // FAVORITES
  // =========================================================================

  // Favorites are the only thing here the user actually authored, so these
  // writes deliberately do NOT swallow failures: a bookmark that silently
  // failed to save would leave the UI showing a state that does not survive
  // the next launch. Callers decide how to surface it.

  static List<TermModel> getFavorites() {
    try {
      return _favoritesBoxInstance.values
          .map((j) => TermModel.fromJson(Map<String, dynamic>.from(j)))
          .toList();
    } catch (error) {
      _reportBestEffortFailure('getFavorites', error);
      return [];
    }
  }

  static Future<void> addFavorite(TermModel term) =>
      _favoritesBoxInstance.put(term.id.toString(), term.toJson());

  static Future<void> removeFavorite(int termId) =>
      _favoritesBoxInstance.delete(termId.toString());

  static bool isFavorite(int termId) {
    try {
      return _favoritesBoxInstance.containsKey(termId.toString());
    } catch (error) {
      _reportBestEffortFailure('isFavorite', error);
      return false;
    }
  }

  static Future<void> clearFavorites() => _favoritesBoxInstance.clear();

  // =========================================================================
  // CACHED TERMS — all use _readTermsList / _writeTermsList
  // =========================================================================

  // --- All terms (paginated) ------------------------------------------------

  static List<TermModel>? getCachedAllTerms(int page) =>
      _readTermsList(_allTermsCacheKey(page));

  static Future<void> cacheAllTerms(int page, List<TermModel> terms) =>
      _writeTermsList(_allTermsCacheKey(page), terms);

  // --- Category terms -------------------------------------------------------

  static List<TermModel>? getCachedCategoryTerms(String category) =>
      _readTermsList(_categoryTermsCacheKey(category));

  static Future<void> cacheCategoryTerms(
          String category, List<TermModel> terms) =>
      _writeTermsList(_categoryTermsCacheKey(category), terms);

  // --- Search results -------------------------------------------------------

  static List<TermModel>? getCachedSearchResults(String query) =>
      _readTermsList(_searchTermsCacheKey(query));

  static Future<void> cacheSearchResults(String query, List<TermModel> terms) =>
      _writeTermsList(_searchTermsCacheKey(query), terms);

  // --- Daily term -----------------------------------------------------------

  static TermModel? getCachedDailyTerm() {
    try {
      final key = _dailyTermCacheKey();
      if (!_isCacheValid(key)) return null;
      final termData = _cachedTermsBoxInstance.get(key)?['term'] as Map?;
      if (termData == null) return null;
      return TermModel.fromJson(Map<String, dynamic>.from(termData));
    } catch (error) {
      _reportBestEffortFailure('getCachedDailyTerm', error);
      return null;
    }
  }

  static Future<void> cacheDailyTerm(TermModel term) async {
    try {
      final key = _dailyTermCacheKey();
      await _cachedTermsBoxInstance.put(key, {'term': term.toJson()});
      await _setCacheTimestamp(key);
    } catch (error) {
      _reportBestEffortFailure('cacheDailyTerm', error);
    }
  }

  // --- Daily trending terms -------------------------------------------------

  static List<TermModel>? getCachedDailyTrendingTerms() =>
      _readTermsList(_dailyTrendingTermsCacheKey());

  static Future<void> cacheDailyTrendingTerms(List<TermModel> terms) =>
      _writeTermsList(_dailyTrendingTermsCacheKey(), terms);

  // --- Total count ----------------------------------------------------------

  static int? getCachedTotalCount() {
    try {
      if (!_isCacheValid(_totalCountKey)) return null;
      final value = _cacheMetadataBoxInstance.get('${_totalCountKey}_value');
      return value is int ? value : null;
    } catch (error) {
      _reportBestEffortFailure('getCachedTotalCount', error);
      return null;
    }
  }

  static Future<void> cacheTotalCount(int count) async {
    try {
      await _cacheMetadataBoxInstance.put('${_totalCountKey}_value', count);
      await _setCacheTimestamp(_totalCountKey);
    } catch (error) {
      _reportBestEffortFailure('cacheTotalCount', error);
    }
  }

  // =========================================================================
  // CACHE CLEARING
  // =========================================================================

  static Future<void> clearCache() async {
    try {
      await _cachedTermsBoxInstance.clear();
      await _cacheMetadataBoxInstance.clear();
    } catch (error) {
      _reportBestEffortFailure('clearCache', error);
    }
  }

  static Future<void> clearAllTermsCache() async {
    try {
      final keysToRemove = _cachedTermsBoxInstance.keys
          .where((k) => k.toString().startsWith('all_terms_page_'))
          .toList();
      for (final key in keysToRemove) {
        await _deleteCacheEntry(key.toString());
      }
    } catch (error) {
      _reportBestEffortFailure('clearAllTermsCache', error);
    }
  }

  // =========================================================================
  // WEAK WORDS (offline tracking for quiz)
  // =========================================================================

  static const String _weakWordsBox = 'weak_words';

  static Box<Map> get _weakWordsBoxInstance => Hive.box<Map>(_weakWordsBox);

  static List<TermModel> getWeakWords() {
    try {
      return _weakWordsBoxInstance.values
          .map((e) => TermModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (error) {
      _reportBestEffortFailure('getWeakWords', error);
      return [];
    }
  }

  static Future<void> addWeakWord(TermModel term) async {
    try {
      await _weakWordsBoxInstance.put(term.id.toString(), term.toJson());
    } catch (error) {
      _reportBestEffortFailure('addWeakWord', error);
    }
  }

  static Future<void> removeWeakWord(int termId) async {
    try {
      await _weakWordsBoxInstance.delete(termId.toString());
    } catch (error) {
      _reportBestEffortFailure('removeWeakWord', error);
    }
  }

  static Future<void> clearWeakWords() async {
    try {
      await _weakWordsBoxInstance.clear();
    } catch (error) {
      _reportBestEffortFailure('clearWeakWords', error);
    }
  }

  // =========================================================================
  // CLEAR ALL (debug / reset)
  // =========================================================================

  static Future<void> clearAllData() async {
    try {
      await _recentlyViewedBoxInstance.clear();
      await _recentlySearchedBoxInstance.clear();
      await _recentlyViewedHistoryBoxInstance.clear();
      await _favoritesBoxInstance.clear();
      await _cachedTermsBoxInstance.clear();
      await _cacheMetadataBoxInstance.clear();
      await _appSettingsBoxInstance.clear();
      await _weakWordsBoxInstance.clear();
    } catch (error) {
      _reportBestEffortFailure('clearAllData', error);
    }
  }
}