import 'package:supabase_flutter/supabase_flutter.dart';


class RemoteDataSource {
  final SupabaseClient _supabase;

  const RemoteDataSource({required SupabaseClient supabase})
      : _supabase = supabase;

 
}