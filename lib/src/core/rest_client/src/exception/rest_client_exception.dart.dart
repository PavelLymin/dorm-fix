sealed class RestClientException implements Exception {
  const RestClientException({
    required this.message,
    this.statusCode,
    this.cause,
  });

  final String message;
  final int? statusCode;
  final Object? cause;
}

final class ClientException extends RestClientException {
  const ClientException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() =>
      'ClientException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}

final class StructuredBackendException extends RestClientException {
  const StructuredBackendException({required this.error, super.statusCode})
    : super(message: 'Backend returned structured error');

  final Map<String, Object?> error;

  @override
  String toString() =>
      'StructuredBackendException('
      'message: $message, '
      'error: $error, '
      'statusCode: $statusCode, '
      ')';
}

final class NetworkException extends RestClientException {
  const NetworkException({
    required super.message,
    super.statusCode,
    super.cause,
  });

  @override
  String toString() =>
      'NetworkException('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}
