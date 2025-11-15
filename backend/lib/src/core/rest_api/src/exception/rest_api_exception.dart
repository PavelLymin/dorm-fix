sealed class RestApiException implements Exception {
  const RestApiException({
    required this.statusCode,
    this.message = 'Error processing request.',
    required this.error,
  });

  final int statusCode;
  final String message;
  final Map<String, Object?> error;

  Map<String, Object> toJson() => {'message': message, 'error': error};
}

final class BadRequestException extends RestApiException {
  const BadRequestException({
    super.statusCode = 400,
    required super.message,
    required super.error,
  });

  @override
  String toString() =>
      'BadRequestException('
      'statusCode: $statusCode, '
      'message: $message, '
      'error: $error'
      ')';
}

final class UnauthorizedException extends RestApiException {
  const UnauthorizedException({
    super.statusCode = 401,
    super.message = 'You are not authorized to access this resource.',
    required super.error,
  });

  @override
  String toString() =>
      'UnauthorizedException('
      'statusCode: $statusCode, '
      'message: $message, '
      'error: $error'
      ')';
}

final class ForbiddenException extends RestApiException {
  const ForbiddenException({
    super.statusCode = 403,
    super.message = 'You do not have permission to access this resource.',
    required super.error,
  });

  @override
  String toString() =>
      'ForbiddenException('
      'statusCode: $statusCode, '
      'message: $message, '
      'error: $error'
      ')';
}

final class NotFoundException extends RestApiException {
  const NotFoundException({
    super.statusCode = 404,
    required super.message,
    required super.error,
  });

  @override
  String toString() =>
      'NotFoundException('
      'statusCode: $statusCode, '
      'message: $message, '
      'error: $error'
      ')';
}

final class InternalServerException extends RestApiException {
  const InternalServerException({
    super.statusCode = 500,
    super.message = 'Error processing request.',
    required super.error,
  });

  @override
  String toString() =>
      'InternalServerException('
      'statusCode: $statusCode, '
      'message: $message, '
      'error: $error'
      ')';
}
