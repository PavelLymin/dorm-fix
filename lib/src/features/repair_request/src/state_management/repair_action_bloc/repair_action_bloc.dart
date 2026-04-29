import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../request.dart';
import '../request_form_bloc/request_form_model.dart';

part 'repair_action_event.dart';
part 'repair_action_state.dart';

class RepairActionBloc extends Bloc<RepairActionEvent, RepairActionState> {
  RepairActionBloc({
    required this._requestRepository,
    required this._problemRepository,
    required this._logger,
  }) : super(const .initial()) {
    on<RepairActionEvent>(
      (event, emit) async => await event.map(
        create: (e) => _create(e, emit),
        accept: (e) => _accept(e, emit),
        updateStatus: (e) => _updateStatus(e, emit),
      ),
      transformer: droppable(),
    );
  }

  final IRequestRepository _requestRepository;
  final IProblemRepository _problemRepository;
  final Logger _logger;

  Future<void> _create(
    _CreateRepairRequestsEvent event,
    Emitter<RepairActionState> emit,
  ) async {
    try {
      final request = event.request.toEntity();
      final newRequest = await _requestRepository.createRequest(
        request: request,
      );

      await _problemRepository.uploadProblems(
        problems: event.request.problems,
        requestId: newRequest.id,
      );
      emit(const .success());
    } on Object catch (e, stackTrace) {
      addError(e, stackTrace);
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(message: e));
    }
  }

  Future<void> _accept(
    _AcceptRepairRequestsEvent e,
    Emitter<RepairActionState> emit,
  ) async {
    try {
      await _requestRepository.acceptRequest(id: e.requestId);
      emit(const .success());
    } on Object catch (e, stackTrace) {
      addError(e, stackTrace);
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(message: e));
    }
  }

  Future<void> _updateStatus(
    _UpdateStatusRepairRequestsEvent e,
    Emitter<RepairActionState> emit,
  ) async {
    try {
      await _requestRepository.updateStatus(id: e.id, status: e.status);
      emit(const .success());
    } on Object catch (e, stackTrace) {
      addError(e, stackTrace);
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(message: e));
    }
  }
}
