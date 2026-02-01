import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:transly/domain/models.dart';
import 'error_handler.dart';

abstract class RemoteDataSource {
  Future<TermModel> getDailyTerm();
  Future<List<TermModel>> searchTerms(String query);
  Future<List<TermModel>> getTermsByCategory(String category);
  Future<TermModel> getTermById(int id);
  Future<List<TermModel>> getAllTerms({int page = 0, int pageSize = 20});
  Future<int> getTotalTermsCount();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient _supabase;
  static const String _tableName = 'definitions';

  const RemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

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
          .or('latin_term.ilike.%$query%,english_term.ilike.%$query%,simple_definition.ilike.%$query%')
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
      final response = await _supabase
          .from(_tableName)
          .select()
          .eq('id', id)
          .single();

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
}