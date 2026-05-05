// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get english_lang => 'English';

  @override
  String photo_upload_progress(int current, int total) {
    return '$current of $total photos uploaded';
  }

  @override
  String get your_data => 'Your Data';

  @override
  String get your_applications => 'Your Applications';

  @override
  String get enter_sms_code => 'Enter SMS code';

  @override
  String get enter_phone_number => 'Enter phone number';

  @override
  String get enter_reason => 'Enter reason';

  @override
  String get enter_problem => 'Enter problem';

  @override
  String get enter_text => 'Enter text';

  @override
  String get enabled => 'Enabled';

  @override
  String get login_via_telegram => 'Log in via Telegram';

  @override
  String get login_via_google => 'Log in via Google';

  @override
  String get all => 'All';

  @override
  String get login_to_profile => 'Profile Login';

  @override
  String get select_materials_used => 'Select materials used';

  @override
  String get select_master_or_service => 'Select master or service';

  @override
  String get select_dormitory => 'Select dormitory';

  @override
  String get select_specialization => 'Select specialization';

  @override
  String get material_selection => 'Material selection';

  @override
  String get dormitory_selection => 'Dormitory selection';

  @override
  String get select => 'Select';

  @override
  String get select_date => 'Select date';

  @override
  String get select_more => 'Select more';

  @override
  String get select_materials => 'Select materials';

  @override
  String get logout => 'Log out';

  @override
  String get home => 'Home';

  @override
  String get date => 'Date';

  @override
  String get treatment_date_time => 'Pest control date & time';

  @override
  String get repair_date_time => 'Repair date & time';

  @override
  String get details => 'Details';

  @override
  String get add => 'Add';

  @override
  String get add_photo => 'Add photo';

  @override
  String get additional => 'Additional';

  @override
  String get other => 'Other';

  @override
  String get completed_f => 'Completed';

  @override
  String get completed_m => 'Completed';

  @override
  String get finish => 'Finish';

  @override
  String get finish_application => 'Complete application';

  @override
  String get upload_photos => 'Upload photos';

  @override
  String get application => 'Application';

  @override
  String get applications => 'Applications';

  @override
  String get edit_name_and_photo => 'Edit name and photo';

  @override
  String get change_quantity => 'Change quantity';

  @override
  String get name => 'Name';

  @override
  String get application_history => 'Application history';

  @override
  String get how_was_repair => 'How was the repair?';

  @override
  String get quantity => 'Quantity';

  @override
  String get master_comment => 'Master\'s comment';

  @override
  String get room => 'Room';

  @override
  String get master => 'Master';

  @override
  String get master_or_service => 'Master or service';

  @override
  String get material => 'Material';

  @override
  String get materials => 'Materials';

  @override
  String get click_to_upload => 'Click to upload';

  @override
  String get not_done => 'Not done';

  @override
  String get no_active_repairs => 'No active repair applications';

  @override
  String get nothing_found => 'Nothing found';

  @override
  String get room_number => 'Room number';

  @override
  String get phone_number => 'Phone number';

  @override
  String get dormitory => 'Dormitory';

  @override
  String dormitory_number(int number) {
    return 'Dormitory №$number';
  }

  @override
  String get description => 'Description';

  @override
  String get describe_problem => 'Describe the problem';

  @override
  String get leave_review => 'Leave a review';

  @override
  String get reply => 'Reply';

  @override
  String get review => 'Review';

  @override
  String get reviews => 'Reviews';

  @override
  String get rejected => 'Rejected';

  @override
  String get decline => 'Decline';

  @override
  String get decline_application => 'Decline application';

  @override
  String get cancel_selection => 'Cancel selection';

  @override
  String get cancel_application => 'Cancel application';

  @override
  String sent_to_number(String phone) {
    return 'Sent to $phone';
  }

  @override
  String get sms_confirmation_hint =>
      'We will send an SMS code for confirmation';

  @override
  String get send_application => 'Send application';

  @override
  String get passed_to_master => 'Passed to master';

  @override
  String get personal_data => 'Personal data';

  @override
  String get repeat_application => 'Repeat application';

  @override
  String get search => 'Search';

  @override
  String get accept_application => 'Accept application';

  @override
  String get continue_btn => 'Continue';

  @override
  String get profile => 'Profile';

  @override
  String get russian_lang => 'Russian';

  @override
  String get light_theme => 'Light';

  @override
  String get system_theme => 'System';

  @override
  String get system_data => 'System data';

  @override
  String get advice => 'Tip';

  @override
  String get advices => 'Tips';

  @override
  String get repair_advices => 'Repair tips';

  @override
  String get creating_application => 'Creating application';

  @override
  String get created => 'Created';

  @override
  String get create_application => 'Create application';

  @override
  String get save => 'Save';

  @override
  String get specialization => 'Specialization';

  @override
  String get masters_list => 'Masters list';

  @override
  String get status => 'Status';

  @override
  String get application_status => 'Application status';

  @override
  String get status_changed => 'Application status changed';

  @override
  String get subject => 'Subject';

  @override
  String get dark_theme => 'Dark';

  @override
  String get notifications => 'Notifications';

  @override
  String get specify_time => 'Specify time';

  @override
  String get specify_date => 'Specify date';

  @override
  String get specify_name => 'Specify name';

  @override
  String get specify_quantity => 'Specify quantity';

  @override
  String get specify_room => 'Specify room';

  @override
  String get specify_number => 'Specify number';

  @override
  String get specify_mail => 'Specify mail';

  @override
  String get specify_reason => 'Specify reason';

  @override
  String get language => 'Language';

  @override
  String get error_field_required => 'This field is required';

  @override
  String get error_invalid_phone => 'Invalid phone number';

  @override
  String get error_something_went_wrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get confirm => 'Confirm';

  @override
  String get success => 'Success';
}
