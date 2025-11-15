class Config {
  const Config();
  // --- ENVIRONMENT --- //

  /// Environment flavor.
  /// e.g. development, staging, production
  EnvironmentFlavor get environment => EnvironmentFlavor.from(
    const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development'),
  );

  // --- DATABASE --- //
  String get databasePath => const String.fromEnvironment(
    'DATABASE_PATH',
    defaultValue: 'database.db',
  );

  // --- SERVER --- //
  String get port => const String.fromEnvironment('PORT', defaultValue: '8080');

  // --- FIREBASE --- //
  String get serviceAccount => const String.fromEnvironment(
    'SERVICE_ACCOUNT',
    defaultValue:
        '/Users/pavellyamin/Development/dorm_fix/backend/bin/service-account.json',
  );

  // --- REGEX --- //
  RegExp get email =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
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
