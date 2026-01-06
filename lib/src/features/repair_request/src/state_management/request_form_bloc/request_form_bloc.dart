import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../request.dart';
import 'request_form_model.dart';

part 'form_state.dart';
part 'form_event.dart';

class RequestFormBloc extends Bloc<RequestFormEvent, RequestFormState> {
  RequestFormBloc({
    required IRequestRepository requestRepository,
    required IImageRepository imageRepository,
    required Logger logger,
  }) : _imageRepository = imageRepository,
       super(const .form(formModel: RequestFormModel())) {
    on<RequestFormEvent>((event, emit) async {
      await event.map(
        updateRequestForm: (e) => _updateRequestForm(emit, e),
        deleteImage: (e) => _deleteImage(emit, e),
        addImages: (e) => _addImages(emit, e),
        loadImages: (e) => _loadImages(emit, e),
        clearForm: (_) => _clearForm(emit),
      );
    });
  }

  final IImageRepository _imageRepository;

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

  void _clearForm(Emitter<RequestFormState> emit) =>
      emit(const .form(formModel: RequestFormModel()));

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
}
