// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get english_lang => 'Английский';

  @override
  String photo_upload_progress(int current, int total) {
    return '$current из $total фото загружено';
  }

  @override
  String get your_data => 'Ваши данные';

  @override
  String get your_applications => 'Ваши заявки';

  @override
  String get enter_sms_code => 'Введите код из SMS';

  @override
  String get enter_phone_number => 'Введите номер телефона';

  @override
  String get enter_reason => 'Введите причину';

  @override
  String get enter_problem => 'Введите проблему';

  @override
  String get enter_text => 'Введите текст';

  @override
  String get enabled => 'Включены';

  @override
  String get login_via_telegram => 'Войти с помощью Telegram';

  @override
  String get login_via_google => 'Войти с помощью Google';

  @override
  String get all => 'Все';

  @override
  String get login_to_profile => 'Вход в профиль';

  @override
  String get select_materials_used => 'Выберите использованные материалы';

  @override
  String get select_master_or_service => 'Выберите мастера или услугу';

  @override
  String get select_dormitory => 'Выберите общежитие';

  @override
  String get select_specialization => 'Выберите специализацию';

  @override
  String get material_selection => 'Выбор материалов';

  @override
  String get dormitory_selection => 'Выбор общежития';

  @override
  String get select => 'Выбрать';

  @override
  String get select_date => 'Выбрать дату';

  @override
  String get select_more => 'Выбрать еще';

  @override
  String get select_materials => 'Выбрать материалы';

  @override
  String get logout => 'Выйти из профиля';

  @override
  String get home => 'Главная';

  @override
  String get date => 'Дата';

  @override
  String get treatment_date_time => 'Дата и время протравки';

  @override
  String get repair_date_time => 'Дата и время ремонта';

  @override
  String get details => 'Детали';

  @override
  String get add => 'Добавить';

  @override
  String get add_photo => 'Добавьте фото';

  @override
  String get additional => 'Дополнительно';

  @override
  String get other => 'Другое';

  @override
  String get completed_f => 'Завершена';

  @override
  String get completed_m => 'Завершенно';

  @override
  String get finish => 'Завершить';

  @override
  String get finish_application => 'Завершить заявку';

  @override
  String get upload_photos => 'Загрузите фотографии';

  @override
  String get application => 'Заявка';

  @override
  String get applications => 'Заявки';

  @override
  String get edit_name_and_photo => 'Изменить имя и фото';

  @override
  String get change_quantity => 'Изменить количество';

  @override
  String get name => 'Имя';

  @override
  String get application_history => 'История заявок';

  @override
  String get how_was_repair => 'Как прошел ремонт?';

  @override
  String get quantity => 'Количество';

  @override
  String get master_comment => 'Комментарий мастера';

  @override
  String get room => 'Комната';

  @override
  String get master => 'Мастер';

  @override
  String get master_or_service => 'Мастер или услуга';

  @override
  String get material => 'Материал';

  @override
  String get materials => 'Материалы';

  @override
  String get click_to_upload => 'Нажмите для загрузки';

  @override
  String get not_done => 'Не сделано';

  @override
  String get no_active_repairs => 'Нет активных заявок на ремонт';

  @override
  String get nothing_found => 'Ничего не найдено';

  @override
  String get room_number => 'Номер комнаты';

  @override
  String get phone_number => 'Номер телефона';

  @override
  String get dormitory => 'Общежитие';

  @override
  String dormitory_number(int number) {
    return 'Общежитие №$number';
  }

  @override
  String get description => 'Описание';

  @override
  String get describe_problem => 'Опишите проблему';

  @override
  String get leave_review => 'Оставить отзыв';

  @override
  String get reply => 'Ответить';

  @override
  String get review => 'Отзыв';

  @override
  String get reviews => 'Отзывы';

  @override
  String get rejected => 'Отказано';

  @override
  String get decline => 'Отклонить';

  @override
  String get decline_application => 'Отклонить заявку';

  @override
  String get cancel_selection => 'Отменить выбор';

  @override
  String get cancel_application => 'Отменить заявку';

  @override
  String sent_to_number(String phone) {
    return 'Отправили на номер $phone';
  }

  @override
  String get sms_confirmation_hint =>
      'Отправим на него SMS-код для подтверждения';

  @override
  String get send_application => 'Отправить заявку';

  @override
  String get passed_to_master => 'Передано мастеру';

  @override
  String get personal_data => 'Персональные данные';

  @override
  String get repeat_application => 'Повторить заявку';

  @override
  String get search => 'Поиск';

  @override
  String get accept_application => 'Принять заявку';

  @override
  String get continue_btn => 'Продолжить';

  @override
  String get profile => 'Профиль';

  @override
  String get russian_lang => 'Русский';

  @override
  String get light_theme => 'Светлая';

  @override
  String get system_theme => 'Системная';

  @override
  String get system_data => 'Системные данные';

  @override
  String get advice => 'Совет';

  @override
  String get advices => 'Советы';

  @override
  String get repair_advices => 'Советы по ремонту';

  @override
  String get creating_application => 'Создание заявки';

  @override
  String get created => 'Создано';

  @override
  String get create_application => 'Создать заявку';

  @override
  String get save => 'Сохранить';

  @override
  String get specialization => 'Специализация';

  @override
  String get masters_list => 'Список мастеров';

  @override
  String get status => 'Статус';

  @override
  String get application_status => 'Статус заявки';

  @override
  String get status_changed => 'Статус заявки изменился';

  @override
  String get subject => 'Тема';

  @override
  String get dark_theme => 'Темная';

  @override
  String get notifications => 'Уведомления';

  @override
  String get specify_time => 'Укажите время';

  @override
  String get specify_date => 'Укажите дату';

  @override
  String get specify_name => 'Укажите имя';

  @override
  String get specify_quantity => 'Укажите количество';

  @override
  String get specify_room => 'Укажите комнату';

  @override
  String get specify_number => 'Укажите номер';

  @override
  String get specify_mail => 'Укажите почту';

  @override
  String get specify_reason => 'Укажите причину';

  @override
  String get language => 'Язык';

  @override
  String get error_field_required => 'Это поле обязательно';

  @override
  String get error_invalid_phone => 'Некорректный номер телефона';

  @override
  String get error_something_went_wrong => 'Что-то пошло не так';

  @override
  String get retry => 'Повторить';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get success => 'Успешно';
}
