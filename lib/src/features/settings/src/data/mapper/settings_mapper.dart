import '../../../../../core/coomon/common.dart';
import '../../model/settings.dart';

const generalSettingsCodec = SettingsCodec();

class SettingsCodec extends JsonMapCodec<SettingsEntity> {
  const SettingsCodec();

  @override
  SettingsEntity $decode(Map<String, Object?> input) {
    final themeMode = input['themeMode'] as String?;
    final locale = input['locale'] as String?;

    const defaults = SettingsEntity();

    return SettingsEntity(
      themeMode: themeMode != null
          ? ThemeModeVO.values.byName(themeMode)
          : defaults.themeMode,
      locale: locale != null ? LocaleVO.values.byName(locale) : defaults.locale,
    );
  }

  @override
  Map<String, Object?> $encode(SettingsEntity input) {
    return {'themeMode': input.themeMode.name, 'locale': input.locale.name};
  }
}
