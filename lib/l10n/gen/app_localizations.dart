import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @english_lang.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english_lang;

  /// Photo upload status
  ///
  /// In en, this message translates to:
  /// **'{current} of {total} photos uploaded'**
  String photo_upload_progress(int current, int total);

  /// No description provided for @your_data.
  ///
  /// In en, this message translates to:
  /// **'Your Data'**
  String get your_data;

  /// No description provided for @your_applications.
  ///
  /// In en, this message translates to:
  /// **'Your Applications'**
  String get your_applications;

  /// No description provided for @enter_sms_code.
  ///
  /// In en, this message translates to:
  /// **'Enter SMS code'**
  String get enter_sms_code;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enter_phone_number;

  /// No description provided for @enter_reason.
  ///
  /// In en, this message translates to:
  /// **'Enter reason'**
  String get enter_reason;

  /// No description provided for @enter_problem.
  ///
  /// In en, this message translates to:
  /// **'Enter problem'**
  String get enter_problem;

  /// No description provided for @enter_text.
  ///
  /// In en, this message translates to:
  /// **'Enter text'**
  String get enter_text;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @login_via_telegram.
  ///
  /// In en, this message translates to:
  /// **'Log in via Telegram'**
  String get login_via_telegram;

  /// No description provided for @login_via_google.
  ///
  /// In en, this message translates to:
  /// **'Log in via Google'**
  String get login_via_google;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @login_to_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile Login'**
  String get login_to_profile;

  /// No description provided for @select_materials_used.
  ///
  /// In en, this message translates to:
  /// **'Select materials used'**
  String get select_materials_used;

  /// No description provided for @select_master_or_service.
  ///
  /// In en, this message translates to:
  /// **'Select master or service'**
  String get select_master_or_service;

  /// No description provided for @select_dormitory.
  ///
  /// In en, this message translates to:
  /// **'Select dormitory'**
  String get select_dormitory;

  /// No description provided for @select_specialization.
  ///
  /// In en, this message translates to:
  /// **'Select specialization'**
  String get select_specialization;

  /// No description provided for @material_selection.
  ///
  /// In en, this message translates to:
  /// **'Material selection'**
  String get material_selection;

  /// No description provided for @dormitory_selection.
  ///
  /// In en, this message translates to:
  /// **'Dormitory selection'**
  String get dormitory_selection;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get select_date;

  /// No description provided for @select_more.
  ///
  /// In en, this message translates to:
  /// **'Select more'**
  String get select_more;

  /// No description provided for @select_materials.
  ///
  /// In en, this message translates to:
  /// **'Select materials'**
  String get select_materials;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @treatment_date_time.
  ///
  /// In en, this message translates to:
  /// **'Pest control date & time'**
  String get treatment_date_time;

  /// No description provided for @repair_date_time.
  ///
  /// In en, this message translates to:
  /// **'Repair date & time'**
  String get repair_date_time;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @add_photo.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get add_photo;

  /// No description provided for @additional.
  ///
  /// In en, this message translates to:
  /// **'Additional'**
  String get additional;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @completed_f.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed_f;

  /// No description provided for @completed_m.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed_m;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @finish_application.
  ///
  /// In en, this message translates to:
  /// **'Complete application'**
  String get finish_application;

  /// No description provided for @upload_photos.
  ///
  /// In en, this message translates to:
  /// **'Upload photos'**
  String get upload_photos;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @applications.
  ///
  /// In en, this message translates to:
  /// **'Applications'**
  String get applications;

  /// No description provided for @edit_name_and_photo.
  ///
  /// In en, this message translates to:
  /// **'Edit name and photo'**
  String get edit_name_and_photo;

  /// No description provided for @change_quantity.
  ///
  /// In en, this message translates to:
  /// **'Change quantity'**
  String get change_quantity;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @application_history.
  ///
  /// In en, this message translates to:
  /// **'Application history'**
  String get application_history;

  /// No description provided for @how_was_repair.
  ///
  /// In en, this message translates to:
  /// **'How was the repair?'**
  String get how_was_repair;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @master_comment.
  ///
  /// In en, this message translates to:
  /// **'Master\'s comment'**
  String get master_comment;

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// No description provided for @master.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get master;

  /// No description provided for @master_or_service.
  ///
  /// In en, this message translates to:
  /// **'Master or service'**
  String get master_or_service;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @materials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materials;

  /// No description provided for @click_to_upload.
  ///
  /// In en, this message translates to:
  /// **'Click to upload'**
  String get click_to_upload;

  /// No description provided for @not_done.
  ///
  /// In en, this message translates to:
  /// **'Not done'**
  String get not_done;

  /// No description provided for @no_active_repairs.
  ///
  /// In en, this message translates to:
  /// **'No active repair applications'**
  String get no_active_repairs;

  /// No description provided for @nothing_found.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get nothing_found;

  /// No description provided for @room_number.
  ///
  /// In en, this message translates to:
  /// **'Room number'**
  String get room_number;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// No description provided for @dormitory.
  ///
  /// In en, this message translates to:
  /// **'Dormitory'**
  String get dormitory;

  /// No description provided for @dormitory_number.
  ///
  /// In en, this message translates to:
  /// **'Dormitory №{number}'**
  String dormitory_number(int number);

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @describe_problem.
  ///
  /// In en, this message translates to:
  /// **'Describe the problem'**
  String get describe_problem;

  /// No description provided for @leave_review.
  ///
  /// In en, this message translates to:
  /// **'Leave a review'**
  String get leave_review;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @decline_application.
  ///
  /// In en, this message translates to:
  /// **'Decline application'**
  String get decline_application;

  /// No description provided for @cancel_selection.
  ///
  /// In en, this message translates to:
  /// **'Cancel selection'**
  String get cancel_selection;

  /// No description provided for @cancel_application.
  ///
  /// In en, this message translates to:
  /// **'Cancel application'**
  String get cancel_application;

  /// No description provided for @sent_to_number.
  ///
  /// In en, this message translates to:
  /// **'Sent to {phone}'**
  String sent_to_number(String phone);

  /// No description provided for @sms_confirmation_hint.
  ///
  /// In en, this message translates to:
  /// **'We will send an SMS code for confirmation'**
  String get sms_confirmation_hint;

  /// No description provided for @send_application.
  ///
  /// In en, this message translates to:
  /// **'Send application'**
  String get send_application;

  /// No description provided for @passed_to_master.
  ///
  /// In en, this message translates to:
  /// **'Passed to master'**
  String get passed_to_master;

  /// No description provided for @personal_data.
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get personal_data;

  /// No description provided for @repeat_application.
  ///
  /// In en, this message translates to:
  /// **'Repeat application'**
  String get repeat_application;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @accept_application.
  ///
  /// In en, this message translates to:
  /// **'Accept application'**
  String get accept_application;

  /// No description provided for @continue_btn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_btn;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @russian_lang.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian_lang;

  /// No description provided for @light_theme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light_theme;

  /// No description provided for @system_theme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system_theme;

  /// No description provided for @system_data.
  ///
  /// In en, this message translates to:
  /// **'System data'**
  String get system_data;

  /// No description provided for @advice.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get advice;

  /// No description provided for @advices.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get advices;

  /// No description provided for @repair_advices.
  ///
  /// In en, this message translates to:
  /// **'Repair tips'**
  String get repair_advices;

  /// No description provided for @creating_application.
  ///
  /// In en, this message translates to:
  /// **'Creating application'**
  String get creating_application;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @create_application.
  ///
  /// In en, this message translates to:
  /// **'Create application'**
  String get create_application;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get specialization;

  /// No description provided for @masters_list.
  ///
  /// In en, this message translates to:
  /// **'Masters list'**
  String get masters_list;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @application_status.
  ///
  /// In en, this message translates to:
  /// **'Application status'**
  String get application_status;

  /// No description provided for @status_changed.
  ///
  /// In en, this message translates to:
  /// **'Application status changed'**
  String get status_changed;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark_theme;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @specify_time.
  ///
  /// In en, this message translates to:
  /// **'Specify time'**
  String get specify_time;

  /// No description provided for @specify_date.
  ///
  /// In en, this message translates to:
  /// **'Specify date'**
  String get specify_date;

  /// No description provided for @specify_name.
  ///
  /// In en, this message translates to:
  /// **'Specify name'**
  String get specify_name;

  /// No description provided for @specify_quantity.
  ///
  /// In en, this message translates to:
  /// **'Specify quantity'**
  String get specify_quantity;

  /// No description provided for @specify_room.
  ///
  /// In en, this message translates to:
  /// **'Specify room'**
  String get specify_room;

  /// No description provided for @specify_number.
  ///
  /// In en, this message translates to:
  /// **'Specify number'**
  String get specify_number;

  /// No description provided for @specify_mail.
  ///
  /// In en, this message translates to:
  /// **'Specify mail'**
  String get specify_mail;

  /// No description provided for @specify_reason.
  ///
  /// In en, this message translates to:
  /// **'Specify reason'**
  String get specify_reason;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @error_field_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get error_field_required;

  /// No description provided for @error_invalid_phone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get error_invalid_phone;

  /// No description provided for @error_something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_something_went_wrong;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
