// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get next => 'Далее';

  @override
  String get update => 'Изменить';

  @override
  String get profile => 'Профиль';

  @override
  String get personal_data => 'Персональные данные';

  @override
  String get system_data => 'Системные данные';

  @override
  String get profile_update => 'Изм.';

  @override
  String get email_address => 'Адрес электронной почты';

  @override
  String get phone_number => 'Номер телефона';

  @override
  String get dormitory => 'Общежитие';

  @override
  String dormitory_name(int number) {
    return 'Общежитие $number';
  }

  @override
  String get room => 'Комната';

  @override
  String get notifications => 'Уведомления';

  @override
  String get notifications_on => 'Вкл.';

  @override
  String get notifications_off => 'Выкл.';

  @override
  String get theme => 'Тема';

  @override
  String get theme_light => 'Светлая';

  @override
  String get theme_dark => 'Тёмная';

  @override
  String get theme_system => 'Системная';

  @override
  String get language => 'Язык';

  @override
  String get russian => 'Русский';

  @override
  String get english => 'Английский';

  @override
  String get logout => 'Выйти';

  @override
  String get create_request => 'Создание заявки';

  @override
  String get choose_master => 'Выберите мастера';

  @override
  String get plumber => 'Сантехник';

  @override
  String get electrician => 'Электрик';

  @override
  String get mechanic => 'Слесарь';

  @override
  String get select_date => 'Укажите дату';

  @override
  String get select_time => 'Укажите время';

  @override
  String get describe_problem => 'Опишите проблему';

  @override
  String get enter_problem => 'Введите проблему';

  @override
  String get upload_photos => 'Загрузите фотографии';

  @override
  String get files => 'Файлы';

  @override
  String files_added(Object count) {
    return '$count/5 файлов добавлено';
  }

  @override
  String get submit => 'Отправить';
}
