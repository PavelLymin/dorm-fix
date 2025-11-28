import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/coomon/common.dart';
import '../../model/settings.dart';
import '../mapper/settings_mapper.dart';

abstract interface class ISettingsRepository {
  Future<SettingsEntity> read();

  Future<void> save(SettingsEntity settings);
}

class SettingsRepositoryImpl implements ISettingsRepository {
  const SettingsRepositoryImpl({
    required this.sharedPreferences,
    this.settingsCodec = const SettingsCodec(),
  });

  final SharedPreferencesAsync sharedPreferences;
  final SettingsCodec settingsCodec;

  SharedPreferencesColumnJson get sharedPreferencesColumnJson =>
      SharedPreferencesColumnJson(
        sharedPreferences: sharedPreferences,
        key: 'settings',
      );

  @override
  Future<SettingsEntity> read() async {
    final settingsMap = await sharedPreferencesColumnJson.read();
    if (settingsMap == null) return const SettingsEntity();

    return settingsCodec.decode(settingsMap);
  }

  @override
  Future<void> save(SettingsEntity settings) async {
    final settingsMap = settingsCodec.encode(settings);

    await sharedPreferencesColumnJson.set(settingsMap);
  }
}
