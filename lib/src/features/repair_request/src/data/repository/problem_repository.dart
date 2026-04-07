import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../model/problem.dart';

abstract interface class IProblemRepository {
  Future<List<String>> uploadProblems({
    required List<FullProblem> problems,
    required int requestId,
  });
}

class ProblemRepositoryImpl implements IProblemRepository {
  ProblemRepositoryImpl({required this._supabase});

  final SupabaseClient _supabase;

  @override
  Future<List<String>> uploadProblems({
    required List<FullProblem> problems,
    required int requestId,
  }) async {
    final List<String> urls = [];
    await Future.wait(
      problems.map((problem) async {
        final problemFile = File(problem.photoPath);
        final url = await _supabase.storage
            .from('problems')
            .upload(
              'problem/${problem.photoPath}.png',
              problemFile,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: false,
              ),
            );
        urls.add(url);
      }),
    );

    return urls;
  }
}
