import 'dart:io';

import 'package:http/http.dart' as http;
import '../../rest_client.dart';

Object? checkHttpException(http.ClientException e) => switch (e) {
  final SocketException socketException => NetworkException(
    message: socketException.message,
    cause: socketException,
  ),
  _ => null,
};
