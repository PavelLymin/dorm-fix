import 'package:shared_preferences/shared_preferences.dart';
import 'application/settings_service.dart';
import 'data/repository/settings_repository.dart';

class SettingsContainer {
  const SettingsContainer._(this.settingsService);

  final SettingsService settingsService;

  static Future<SettingsContainer> create({
    required SharedPreferencesAsync sharedPreferences,
  }) async {
    final settingsRepository = SettingsRepositoryImpl(
      sharedPreferences: sharedPreferences,
    );

    final settingsService = await SettingsServiceImpl.create(
      repository: settingsRepository,
    );

    return SettingsContainer._(settingsService);
  }
}
