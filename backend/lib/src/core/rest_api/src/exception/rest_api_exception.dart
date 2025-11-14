sealed class RestApiException implements Exception {
  const RestApiException({
    this.statusCode = 400,
    this.details,
    required this.message,
  });

  final int statusCode;
  final Map<String, dynamic>? details;
  final String message;

  Map<String, dynamic> toJson() => {
    'error': {'message': message, 'details': details ?? {}},
  };
}

final class ValidateException extends RestApiException {
  const ValidateException({
    super.statusCode = 400,
    super.details,
    required super.message,
  });

  @override
  String toString() =>
      'ValidateException('
      'statusCode: $statusCode, '
      'message: $message, '
      'details: $details'
      ')';
}

final class UnauthorizedException extends RestApiException {
  const UnauthorizedException({
    super.statusCode = 403,
    super.details,
    required super.message,
  });

  @override
  String toString() =>
      'UnauthorizedException('
      'statusCode: $statusCode, '
      'message: $message, '
      'details: $details'
      ')';
}

final class NotFoundException extends RestApiException {
  const NotFoundException({
    super.statusCode = 404,
    super.details,
    required super.message,
  });

  @override
  String toString() =>
      'NotFoundException('
      'statusCode: $statusCode, '
      'message: $message, '
      'details: $details'
      ')';
}

final class InternalServerException extends RestApiException {
  const InternalServerException({
    super.statusCode = 500,
    super.details,
    super.message = 'Error processing request.',
  });

  @override
  String toString() =>
      'InternalServerException('
      'statusCode: $statusCode, '
      'message: $message, '
      'details: $details'
      ')';
}
