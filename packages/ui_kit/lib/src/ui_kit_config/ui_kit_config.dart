abstract final class UiKitConfig {
  /// Api key for mapKit.
  static const String mapKitApiKey = String.fromEnvironment(
    'MAPKIT_API_KEY',
    defaultValue: '152caab1-17a7-4ec4-a0b9-aaa267e6b0a8',
  );
}
