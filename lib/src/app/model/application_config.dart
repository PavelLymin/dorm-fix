/// Config for app.
abstract final class Config {
  // --- ENVIRONMENT --- //

  /// Environment flavor.
  /// e.g. development, staging, production
  static final EnvironmentFlavor environment = EnvironmentFlavor.from(
    const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development'),
  );

  // --- API --- //

  /// Base url for api.
  /// e.g. https://api.domain.tld
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080',
  );

  /// Base url for ws.
  /// e.g. ws://api.domain.tld
  static const String wsBaseUrl = String.fromEnvironment(
    'WS_BASE_URL',
    defaultValue: 'ws://10.0.2.2:8080',
  );

  /// Api key for MapKit SDK
  static const String mapKitApiKey = String.fromEnvironment(
    'MAPKIT_API_KEY',
    defaultValue: '152caab1-17a7-4ec4-a0b9-aaa267e6b0a8',
  );

  static const String googleClientId = String.fromEnvironment(
    '889571705211-l3jel9lhdsbq252dvpg51583755n7sm7.apps.googleusercontent.com',
    defaultValue: '',
  );

  /// Timeout in milliseconds for opening url.
  /// [Dio] will throw the [DioException] with [DioExceptionType.connectTimeout] type when time out.
  /// e.g. 15000
  static const Duration apiConnectTimeout = Duration(
    milliseconds: int.fromEnvironment(
      'API_CONNECT_TIMEOUT',
      defaultValue: 15000,
    ),
  );

  /// Timeout in milliseconds for receiving data from url.
  /// [Dio] will throw the [DioException] with [DioExceptionType.receiveTimeout] type when time out.
  /// e.g. 10000
  static const Duration apiReceiveTimeout = Duration(
    milliseconds: int.fromEnvironment(
      'API_RECEIVE_TIMEOUT',
      defaultValue: 10000,
    ),
  );

  /// Cache lifetime.
  /// Refetch data from url when cache is expired.
  /// e.g. 1 hour
  static const Duration cacheLifetime = Duration(hours: 1);

  // --- AUTHENTICATION --- //

  /// Minimum length of password.
  /// e.g. 8
  static const int passwordMinLength = int.fromEnvironment(
    'PASSWORD_MIN_LENGTH',
    defaultValue: 8,
  );

  /// Maximum length of password.
  /// e.g. 32
  static const int passwordMaxLength = int.fromEnvironment(
    'PASSWORD_MAX_LENGTH',
    defaultValue: 32,
  );

  /// Length of pincode.
  /// e.g. 6
  static const int pinCodeLength = int.fromEnvironment(
    'PINCODE_LENGTH',
    defaultValue: 6,
  );

  // --- REGEX --- //
  static RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static RegExp phoneNumber = RegExp(
    r'^\+7\s?\(?\d{3}\)?\s?\d{3}\s?\d{2}\s?\d{2}$',
  );
}

/// Environment flavor.
/// e.g. development, staging, production
enum EnvironmentFlavor {
  /// Development
  development('development'),

  /// Staging
  staging('staging'),

  /// Production
  production('production');

  /// Create environment flavor.
  const EnvironmentFlavor(this.value);

  /// Create environment flavor from string.
  factory EnvironmentFlavor.from(String? value) => switch (value
      ?.trim()
      .toLowerCase()) {
    'development' || 'debug' || 'develop' || 'dev' => development,
    'staging' || 'profile' || 'stage' || 'stg' => staging,
    'production' || 'release' || 'prod' || 'prd' => production,
    _ =>
      const bool.fromEnvironment('dart.vm.product') ? production : development,
  };

  /// development, staging, production
  final String value;

  /// Whether the environment is development.
  bool get isDevelopment => this == development;

  /// Whether the environment is staging.
  bool get isStaging => this == staging;

  /// Whether the environment is production.
  bool get isProduction => this == production;
}
