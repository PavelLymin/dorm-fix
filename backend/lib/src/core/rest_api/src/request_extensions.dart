import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../rest_api.dart';

extension RequestContextExtension on Request {
  String get userId {
    final uid = context['user_id'];
    if (uid is! String || uid.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid user id in request context.',
          'context': 'user_id',
        },
      );
    }

    return uid;
  }
}

extension RequestBodyExtension on Request {
  Future<T> body<T>(T Function(Map<String, Object?>) fromJson) async {
    final payload = await readAsString();
    final json = jsonDecode(payload) as Map<String, Object?>;
    return fromJson(json);
  }
}
