import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  final String supabaseUrl = 'https://nplutfvmegfdhpildljn.supabase.co';
  final String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wbHV0ZnZtZWdmZGhwaWxkbGpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY5NzEzODksImV4cCI6MjA0MjU0NzM4OX0.PzJpx2sU0HFVL6JaACNXWlc0frGaBInopbBOkd8hIAE';
  SupabaseClient? _client;

  SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  Future<void> initialize() async {
    if (_client == null) {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      _client = Supabase.instance.client;
    }
  }

  SupabaseClient get client => _client!;
}
