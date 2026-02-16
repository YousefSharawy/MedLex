import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:transly/domain/models.dart';
import 'error_handler.dart';

abstract class RemoteDataSource {
  // ── Terms ──
  Future<TermModel> getDailyTerm();
  Future<List<TermModel>> searchTerms(String query);
  Future<List<TermModel>> getTermsByCategory(String category);
  Future<TermModel> getTermById(int id);
  Future<List<TermModel>> getAllTerms({int page = 0, int pageSize = 20});
  Future<int> getTotalTermsCount();
  Future<List<TermModel>> getDailyTrendingTerms();

  // ── Auth ──
  User? get currentUser;
  bool get isGoogleLinked;
  bool get hasSession;
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<void> signOut();

  // ── User Favorites (Remote) ──
  Future<void> ensureUserExists(
    String userId, {
    String? email,
    String? displayName,
    String? photoUrl,
  });
  Future<List<int>> getFavoriteTermIds(String userId);
  Future<void> addFavorite(String userId, int termId);
  Future<void> removeFavorite(String userId, int termId);
  Future<void> syncFavorites(String userId, List<int> termIds);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient _supabase;
  static const String _tableName = 'definitions';
  static const String _usersTable = 'users';
  static const String _favoritesTable = 'user_favorites';

  const RemoteDataSourceImpl({required SupabaseClient supabase})
    : _supabase = supabase;

  // =========================================================================
  // TERMS
  // =========================================================================

  @override
  Future<TermModel> getDailyTerm() async {
    try {
      final today = DateTime.now();
      final seed = today.year * 10000 + today.month * 100 + today.day;

      final countResponse = await _supabase
          .from(_tableName)
          .select('id')
          .count(CountOption.exact);

      final count = countResponse.count;
      if (count == 0) {
        throw ErrorHandler.handle(Exception('No terms found')).failture;
      }

      final dailyOffset = seed % count;

      final response = await _supabase
          .from(_tableName)
          .select()
          .range(dailyOffset, dailyOffset);

      return TermModel.fromJson(response.first);
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<List<TermModel>> searchTerms(String query) async {
    try {
      if (query.trim().isEmpty) {
        return [];
      }

      final response = await _supabase
          .from(_tableName)
          .select()
          .or(
            'latin_term.ilike.%$query%,english_term.ilike.%$query%,simple_definition.ilike.%$query%',
          )
          .order('latin_term', ascending: true)
          .limit(50);

      return response
          .map<TermModel>((json) => TermModel.fromJson(json))
          .toList();
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<List<TermModel>> getTermsByCategory(String category) async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .eq('category', category)
          .order('latin_term', ascending: true);

      return response
          .map<TermModel>((json) => TermModel.fromJson(json))
          .toList();
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<TermModel> getTermById(int id) async {
    try {
      final response =
          await _supabase.from(_tableName).select().eq('id', id).single();

      return TermModel.fromJson(response);
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<List<TermModel>> getAllTerms({int page = 0, int pageSize = 20}) async {
    try {
      final start = page * pageSize;
      final end = start + pageSize - 1;

      final response = await _supabase
          .from(_tableName)
          .select()
          .order('latin_term', ascending: true)
          .range(start, end);

      return response
          .map<TermModel>((json) => TermModel.fromJson(json))
          .toList();
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<int> getTotalTermsCount() async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select('id')
          .count(CountOption.exact);

      return response.count;
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<List<TermModel>> getDailyTrendingTerms() async {
    try {
      final today = DateTime.now();
      final seed = today.year * 10000 + today.month * 100 + today.day;

      final countResponse = await _supabase
          .from(_tableName)
          .select('id')
          .count(CountOption.exact);

      final count = countResponse.count;
      if (count == 0) return [];

      final offset = seed % (count > 5 ? count - 5 : 1);

      final response = await _supabase
          .from(_tableName)
          .select()
          .range(offset, offset + 4);

      return response
          .map<TermModel>((json) => TermModel.fromJson(json))
          .toList();
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  // =========================================================================
  // AUTH
  // =========================================================================

  @override
  User? get currentUser => _supabase.auth.currentUser;

  @override
  bool get isGoogleLinked {
    final user = currentUser;
    if (user == null) return false;
    return user.appMetadata['provider'] == 'google' ||
        (user.identities?.any((i) => i.provider == 'google') ?? false);
  }

  @override
  bool get hasSession => _supabase.auth.currentSession != null;

  @override
  Future<User> signInAnonymously() async {
    try {
      final response = await _supabase.auth.signInAnonymously();
      final user = response.user;
      if (user == null) {
        throw Exception('Anonymous sign-in failed: no user returned');
      }
      return user;
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }
@override
Future<User> signInWithGoogle() async {
  try {
    final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
    final androidClientId = dotenv.env['GOOGLE_ANDROID_CLIENT_ID'] ?? '';
    final iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? '';

    String? clientId;
    if (Platform.isIOS) {
      clientId = iosClientId;
    } else if (Platform.isAndroid) {
      clientId = androidClientId;
    }

    // Save anonymous user info BEFORE Google sign-in
    final anonUser = currentUser;
    final anonUserId = (anonUser?.isAnonymous ?? false) ? anonUser!.id : null;

    // Google Sign-In
    final signIn = GoogleSignIn.instance;
    await signIn.initialize(clientId: clientId, serverClientId: webClientId);

    final googleAccount = await signIn.authenticate();

    final googleAuth = googleAccount.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw Exception('Google sign-in failed: no ID token');
    }

    String? accessToken;
    try {
      final authResult = await googleAccount.authorizationClient
          .authorizationForScopes(['email']);
      accessToken = authResult?.accessToken;
    } catch (_) {}

    // Sign in to Supabase (replaces the anonymous session)
    final response = await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    final user = response.user;
    if (user == null) {
      throw Exception('Supabase sign-in failed: no user returned');
    }

    // Ensure Google user exists in public.users
    try {
      await ensureUserExists(
        user.id,
        email: user.email,
        displayName: googleAccount.displayName,
        photoUrl: googleAccount.photoUrl,
      );
    } catch (_) {}

    // Migrate favorites from anonymous → Google user
    if (anonUserId != null && anonUserId != user.id) {
      await _migrateAnonymousData(anonUserId, user.id);
    }

    return user;
  } catch (error) {
    throw ErrorHandler.handle(error).failture;
  }
}

Future<void> _migrateAnonymousData(String fromUserId, String toUserId) async {
  try {
    await _supabase.rpc('migrate_anonymous_user', params: {
      'anon_id': fromUserId,
      'google_id': toUserId,
    });
  } catch (_) {}
}
  @override
  Future<void> signOut() async {
    try {
      try {
        final signIn = GoogleSignIn.instance;
        await signIn.disconnect();
      } catch (_) {}

      await _supabase.auth.signOut();
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  // =========================================================================
  // USER FAVORITES (REMOTE SYNC)
  // =========================================================================

  @override
  Future<void> ensureUserExists(
    String userId, {
    String? email,
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      await _supabase.from(_usersTable).upsert({
        'id': userId,
        if (email != null) 'email': email,
        if (displayName != null) 'display_name': displayName,
        if (photoUrl != null) 'photo_url': photoUrl,
      }, onConflict: 'id');
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<List<int>> getFavoriteTermIds(String userId) async {
    try {
      final response = await _supabase
          .from(_favoritesTable)
          .select('term_id')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return response.map<int>((row) => row['term_id'] as int).toList();
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<void> addFavorite(String userId, int termId) async {
    try {
      await _supabase.from(_favoritesTable).upsert({
        'user_id': userId,
        'term_id': termId,
      }, onConflict: 'user_id,term_id');
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
  Future<void> removeFavorite(String userId, int termId) async {
    try {
      await _supabase
          .from(_favoritesTable)
          .delete()
          .eq('user_id', userId)
          .eq('term_id', termId);
    } catch (error) {
      throw ErrorHandler.handle(error).failture;
    }
  }

  @override
Future<void> syncFavorites(String userId, List<int> termIds) async {
  try {
    if (termIds.isEmpty) return;
    
    
    // Use upsert to handle duplicates gracefully
    final rows = termIds.map((id) => {
      'user_id': userId,
      'term_id': id,
    }).toList();
    
    await _supabase
        .from(_favoritesTable)
        .upsert(rows, onConflict: 'user_id,term_id');
    
  } catch (error) {
    throw ErrorHandler.handle(error).failture;
  }
}
}
