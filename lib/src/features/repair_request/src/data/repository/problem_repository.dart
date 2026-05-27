import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../app/model/application_config.dart';

abstract interface class IProblemRepository {
  Future<List<String>> uploadProblems({
    required List<String> problems,
    required int requestId,
  });

  String getUrl({required String photoPath});
}

class ProblemRepositoryImpl implements IProblemRepository {
  ProblemRepositoryImpl({required this._supabase});

  final SupabaseClient _supabase;

  @override
  Future<List<String>> uploadProblems({
    required List<String> problems,
    required int requestId,
  }) async {
    final List<String> urls = [];
    await Future.wait(
      problems.map((problem) async {
        final path = problem.split('/').last;
        final problemFile = File(problem);
        final url = await _supabase.storage
            .from('problems')
            .upload(
              path,
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

  @override
  String getUrl({required String photoPath}) =>
      _supabase.storage.from(Config.problemsBucket).getPublicUrl(photoPath);
}
