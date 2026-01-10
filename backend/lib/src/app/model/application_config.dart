abstract class Config {
  const Config();
  // --- ENVIRONMENT --- //

  /// Environment flavor.
  /// e.g. development, staging, production
  static EnvironmentFlavor environment = EnvironmentFlavor.from(
    const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development'),
  );

  // --- DATABASE --- //
  static const String databasePath = String.fromEnvironment(
    'DATABASE_PATH',
    defaultValue: 'database.db',
  );

  // --- SERVER --- //
  static const String port = String.fromEnvironment(
    'PORT',
    defaultValue: '8080',
  );

  // --- FIREBASE --- //
  static const String serviceAccount = String.fromEnvironment(
    'SERVICE_ACCOUNT',
    defaultValue: 'bin/service-account.json',
  );

  // --- REGEX --- //
  static RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
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
