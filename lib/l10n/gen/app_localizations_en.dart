// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get next => 'Next';

  @override
  String get update => 'Update';

  @override
  String get profile => 'Profile';

  @override
  String get personal_data => 'Personal information';

  @override
  String get system_data => 'System information';

  @override
  String get profile_update => 'Edit';

  @override
  String get email_address => 'Email address';

  @override
  String get phone_number => 'Phone number';

  @override
  String get dormitory => 'Dormitory';

  @override
  String dormitory_name(int number) {
    return 'Dormitory $number';
  }

  @override
  String get room => 'Room';

  @override
  String get notifications => 'Notifications';

  @override
  String get notifications_on => 'On';

  @override
  String get notifications_off => 'Off';

  @override
  String get theme => 'Theme';

  @override
  String get theme_light => 'Light';

  @override
  String get theme_dark => 'Dark';

  @override
  String get theme_system => 'System';

  @override
  String get language => 'Language';

  @override
  String get russian => 'Russian';

  @override
  String get english => 'English';

  @override
  String get logout => 'Log out';

  @override
  String get create_request => 'Create request';

  @override
  String get choose_master => 'Choose a specialist';

  @override
  String get plumber => 'Plumber';

  @override
  String get electrician => 'Electrician';

  @override
  String get mechanic => 'Mechanic';

  @override
  String get select_date => 'Select date';

  @override
  String get select_time => 'Select time';

  @override
  String get describe_problem => 'Describe the problem';

  @override
  String get enter_problem => 'Enter the problem';

  @override
  String get upload_photos => 'Upload photos';

  @override
  String get files => 'Files';

  @override
  String files_added(Object count) {
    return '$count/5 files added';
  }

  @override
  String get submit => 'Submit';
}
