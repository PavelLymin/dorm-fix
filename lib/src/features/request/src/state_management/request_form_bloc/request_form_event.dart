part of 'request_form_bloc.dart';

sealed class RequestFormEvent {
  const RequestFormEvent();

  const factory RequestFormEvent.setRequestFormValue({
    int? masterId,
    DateTime? date,
    int? startTime,
    int? endTime,
    String description,
    List<XFile>? imageFileList,
  }) = _SetRequestFormValue;
}

final class _SetRequestFormValue extends RequestFormEvent {
  const _SetRequestFormValue({
    this.masterId,
    this.date,
    this.startTime,
    this.endTime,
    this.description = '',
    this.imageFileList,
  });

  final int? masterId;
  final DateTime? date;
  final int? startTime;
  final int? endTime;
  final String description;
  final List<XFile>? imageFileList;
}
