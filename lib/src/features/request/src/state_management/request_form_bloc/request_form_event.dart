part of 'request_form_bloc.dart';

typedef RequestFormEventMatch<R, E extends RequestFormEvent> =
    FutureOr<R> Function(E event);

sealed class RequestFormEvent {
  const RequestFormEvent();

  const factory RequestFormEvent.upadteRequestForm({
    int? specializationId,
    String? description,
    Priority priority,
    bool studentAbsent,
    DateTime? date,
    String? startTime,
    String? endTime,
    List<String> imagePaths,
  }) = _UpadateRequestFormEvent;

  const factory RequestFormEvent.deleteImage({required int index}) =
      _DeleteImageEvent;

  const factory RequestFormEvent.addImages({int limit}) = _AddImagesEvent;

  const factory RequestFormEvent.loadImages() = _LoadImagesEvent;

  const factory RequestFormEvent.submitForm({
    required String description,
    required int specializationId,
  }) = _SubmitFormEvent;

  FutureOr<R> map<R>({
    required RequestFormEventMatch<R, _UpadateRequestFormEvent>
    updateRequestForm,
    required RequestFormEventMatch<R, _DeleteImageEvent> deleteImage,
    required RequestFormEventMatch<R, _AddImagesEvent> addImages,
    required RequestFormEventMatch<R, _LoadImagesEvent> loadImages,
    required RequestFormEventMatch<R, _SubmitFormEvent> submitForm,
  }) => switch (this) {
    _UpadateRequestFormEvent e => updateRequestForm(e),
    _DeleteImageEvent e => deleteImage(e),
    _AddImagesEvent e => addImages(e),
    _LoadImagesEvent e => loadImages(e),
    _SubmitFormEvent e => submitForm(e),
  };
}

final class _UpadateRequestFormEvent extends RequestFormEvent {
  const _UpadateRequestFormEvent({
    this.specializationId,
    this.description,
    this.priority = Priority.ordinary,
    this.studentAbsent,
    this.date,
    this.startTime,
    this.endTime,
    this.imagePaths = const [],
  });

  final int? specializationId;
  final String? description;
  final Priority priority;
  final bool? studentAbsent;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final List<String> imagePaths;
}

final class _DeleteImageEvent extends RequestFormEvent {
  const _DeleteImageEvent({required this.index});

  final int index;
}

final class _AddImagesEvent extends RequestFormEvent {
  const _AddImagesEvent({this.limit = 5});

  final int limit;
}

final class _LoadImagesEvent extends RequestFormEvent {
  const _LoadImagesEvent();
}

final class _SubmitFormEvent extends RequestFormEvent {
  const _SubmitFormEvent({
    required this.description,
    required this.specializationId,
  });

  final String description;
  final int specializationId;
}
