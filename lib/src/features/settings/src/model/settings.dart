enum ThemeModeVO { light, dark, system }

final class SettingsEntity {
  const SettingsEntity({this.themeMode = ThemeModeVO.system});

  final ThemeModeVO themeMode;

  SettingsEntity copyWith({ThemeModeVO? themeMode}) =>
      SettingsEntity(themeMode: themeMode ?? this.themeMode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsEntity && themeMode == other.themeMode;

  @override
  int get hashCode => themeMode.hashCode;
}
