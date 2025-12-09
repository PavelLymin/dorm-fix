import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../request.dart';
import 'request_form_model.dart';

part 'request_form_event.dart';
part 'request_form_state.dart';

class RequestFormBloc extends Bloc<RequestFormEvent, RequestFormState> {
  RequestFormBloc({
    required IRequestRepository requestRepository,
    required IImageRepository imageRepository,
    required Logger logger,
  }) : _requestRepository = requestRepository,
       _imageRepository = imageRepository,
       _logger = logger,
       super(.form(formModel: RequestFormModel())) {
    on<RequestFormEvent>((event, emit) async {
      await event.map(
        updateRequestForm: (e) => _updateRequestForm(emit, e),
        deleteImage: (e) => _deleteImage(emit, e),
        addImages: (e) => _addImages(emit, e),
        loadImages: (e) => _loadImages(emit, e),
        submitForm: (e) => _submitForm(emit, e),
      );
    });
  }

  final IRequestRepository _requestRepository;
  final IImageRepository _imageRepository;
  final Logger _logger;

  void _updateRequestForm(
    Emitter<RequestFormState> emit,
    _UpadateRequestFormEvent e,
  ) {
    final form = state.currentFormModel.copyWith(
      specializationId: e.specializationId,
      description: e.description,
      priority: e.priority,
      studentAbsent: e.studentAbsent,
      date: e.date,
      startTime: e.startTime,
      endTime: e.endTime,
    );
    emit(.form(formModel: form));
  }

  Future<void> _loadImages(
    Emitter<RequestFormState> emit,
    _LoadImagesEvent e,
  ) async {
    final images = await _imageRepository.loadImages();
    final form = state.currentFormModel.copyWith(imagePaths: List.from(images));
    emit(.form(formModel: form));
  }

  Future<void> _addImages(
    Emitter<RequestFormState> emit,
    _AddImagesEvent e,
  ) async {
    await _imageRepository.addImages(limit: e.limit);
    add(const .loadImages());
  }

  Future<void> _deleteImage(
    Emitter<RequestFormState> emit,
    _DeleteImageEvent e,
  ) async {
    await _imageRepository.deleteImage(e.index);
    add(const .loadImages());
  }

  Future<void> _submitForm(
    Emitter<RequestFormState> emit,
    _SubmitFormEvent e,
  ) async {
    try {
      final request = state.currentFormModel
          .copyWith(
            description: e.description,
            specializationId: e.specializationId,
          )
          .toEntity();
      await _requestRepository.createRequest(request: request);
      _clearForm(emit);
    } on StructuredBackendException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      _emitError(emit, e.message);
    } on RestClientException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      _emitError(emit, e.message);
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      _emitError(emit, e.toString());
    }
  }

  void _clearForm(Emitter<RequestFormState> emit) {
    emit(.form(formModel: RequestFormModel()));
  }

  void _emitError(Emitter<RequestFormState> emit, String e) =>
      emit(.error(formModel: state.currentFormModel, message: e));
}
