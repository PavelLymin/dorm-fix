import '../../../../../l10n/gen/app_localizations.dart';

enum ThemeModeVO {
  light,
  dark,
  system;

  T map<T>({
    required T Function(ThemeModeVO) light,
    required T Function(ThemeModeVO) dark,
    required T Function(ThemeModeVO) system,
  }) => switch (this) {
    .light => light(.light),
    .dark => dark(.dark),
    .system => system(.system),
  };
}

extension ThemeModeVOLocalization on ThemeModeVO {
  String label(AppLocalizations l10n) => map(
    light: (_) => l10n.light_theme,
    dark: (_) => l10n.dark_theme,
    system: (_) => l10n.system_theme,
  );
}

enum LocaleVO {
  russian(locale: 'ru_RU'),
  english(locale: 'en_US');

  const LocaleVO({required this.locale});
  final String locale;

  T map<T>({
    required T Function(LocaleVO) russian,
    required T Function(LocaleVO) english,
  }) => switch (this) {
    .russian => russian(.russian),
    .english => english(.english),
  };
}

extension LocaleVOLocalization on LocaleVO {
  String label(AppLocalizations l10n) =>
      map(russian: (_) => l10n.russian_lang, english: (_) => l10n.english_lang);
}

final class SettingsEntity {
  const SettingsEntity({this.themeMode = .system, this.locale = .english});

  final ThemeModeVO themeMode;
  final LocaleVO locale;

  SettingsEntity copyWith({ThemeModeVO? themeMode, LocaleVO? locale}) =>
      SettingsEntity(
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this.locale,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsEntity &&
        themeMode == other.themeMode &&
        locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([themeMode.hashCode, locale.hashCode]);
}
