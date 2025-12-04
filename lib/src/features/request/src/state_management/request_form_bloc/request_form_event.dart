part of 'request_form_bloc.dart';

sealed class RequestFormEvent {
  const RequestFormEvent();

  const factory RequestFormEvent.setRequestFormValue({
    int? masterId,
    DateTime? date,
    int? startTime,
    int? endTime,
    String description,
  }) = _SetRequestFormValue;
}

final class _SetRequestFormValue extends RequestFormEvent {
  const _SetRequestFormValue({
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
}
