enum ThemeModeVO { light, dark, system }

final class SettingsEntity {
  const SettingsEntity({this.themeMode = ThemeModeVO.system});

  final ThemeModeVO themeMode;

  T map<T>({
    required T Function(ThemeModeVO) light,
    required T Function(ThemeModeVO) dark,
    required T Function(ThemeModeVO) system,
  }) => switch (themeMode) {
    ThemeModeVO.light => light(ThemeModeVO.light),
    ThemeModeVO.dark => dark(ThemeModeVO.dark),
    ThemeModeVO.system => system(ThemeModeVO.system),
  };

  SettingsEntity copyWith({ThemeModeVO? themeMode}) =>
      SettingsEntity(themeMode: themeMode ?? this.themeMode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsEntity && themeMode == other.themeMode;

  @override
  int get hashCode => themeMode.hashCode;
}
