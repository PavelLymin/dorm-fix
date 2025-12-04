part of 'request_form_bloc.dart';

class RequestFormState {
  const RequestFormState({
    this.masterId,
    this.date,
    this.startTime,
    this.endTime,
    this.description = '',
  });

  final int? masterId;
  final DateTime? date;
  final int? startTime;
  final int? endTime;
  final String description;

  bool get isValid {
    return masterId != null &&
        date != null &&
        startTime != null &&
        endTime != null &&
        description.isNotEmpty;
  }
}
