enum ThemeModeVO {
  light(value: 'Светлая'),
  dark(value: 'Темная'),
  system(value: 'Системная');

  const ThemeModeVO({required this.value});
  final String value;
}

final class SettingsEntity {
  const SettingsEntity({this.themeMode = .system});

  final ThemeModeVO themeMode;

  T map<T>({
    required T Function(ThemeModeVO) light,
    required T Function(ThemeModeVO) dark,
    required T Function(ThemeModeVO) system,
  }) => switch (themeMode) {
    .light => light(.light),
    .dark => dark(.dark),
    .system => system(.system),
  };

  SettingsEntity copyWith({ThemeModeVO? themeMode}) =>
      SettingsEntity(themeMode: themeMode ?? this.themeMode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsEntity && themeMode == other.themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;
}
