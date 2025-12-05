part of 'request_form_bloc.dart';

class RequestFormState {
  const RequestFormState({
    int? masterId,
    DateTime? date,
    int? startTime,
    int? endTime,
    String description = '',
    List<XFile>? imageFileList,
  }) : _masterId = masterId,
       _date = date,
       _startTime = startTime,
       _endTime = endTime,
       _description = description,
       _imageFileList = imageFileList;

  final int? _masterId;
  final DateTime? _date;
  final int? _startTime;
  final int? _endTime;
  final String _description;
  final List<XFile>? _imageFileList;

  bool get isValid =>
      _masterId != null &&
      _date != null &&
      _startTime != null &&
      _endTime != null &&
      _description.isNotEmpty;

  String get date {
    if (_date == null) return 'Укажите дату';
    return _date.toLocal().toString();
  }

  String get time {
    if (_startTime == null || _endTime == null) return 'Укажите время';
    return 'С $_startTime до $_endTime часов';
  }

  List<XFile> get imageFileList {
    if (_imageFileList == null) return [];
    return _imageFileList;
  }
}
