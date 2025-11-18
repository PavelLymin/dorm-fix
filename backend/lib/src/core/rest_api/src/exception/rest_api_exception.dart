sealed class RestApiException implements Exception {
  const RestApiException({required this.statusCode, required this.error});

  final int statusCode;
  final Map<String, Object?> error;

  Map<String, Object> toJson() => {'error': error};
}

final class BadRequestException extends RestApiException {
  const BadRequestException({super.statusCode = 400, required super.error});

  @override
  String toString() =>
      'BadRequestException('
      'statusCode: $statusCode, '
      'error: $error'
      ')';
}

final class UnauthorizedException extends RestApiException {
  const UnauthorizedException({super.statusCode = 401, required super.error});

  @override
  String toString() =>
      'UnauthorizedException('
      'statusCode: $statusCode, '
      'error: $error'
      ')';
}

final class ForbiddenException extends RestApiException {
  const ForbiddenException({super.statusCode = 403, required super.error});

  @override
  String toString() =>
      'ForbiddenException('
      'statusCode: $statusCode, '
      'error: $error'
      ')';
}

final class NotFoundException extends RestApiException {
  const NotFoundException({super.statusCode = 404, required super.error});

  @override
  String toString() =>
      'NotFoundException('
      'statusCode: $statusCode, '
      'error: $error'
      ')';
}

final class ConflictException extends RestApiException {
  const ConflictException({super.statusCode = 409, required super.error});

  @override
  String toString() =>
      'ConflictException('
      'statusCode: $statusCode, '
      'error: $error'
      ')';
}

final class InternalServerException extends RestApiException {
  const InternalServerException({super.statusCode = 500, required super.error});

  @override
  String toString() =>
      'InternalServerException('
      'statusCode: $statusCode, '
      'error: $error'
      ')';
}
