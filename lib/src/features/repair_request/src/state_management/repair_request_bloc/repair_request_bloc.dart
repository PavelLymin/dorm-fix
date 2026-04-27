import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../request.dart';
import '../request_form_bloc/request_form_model.dart';

part 'repair_request_event.dart';
part 'repair_request_state.dart';

enum RequestFilterType {
  all(value: 'Все'),
  active(value: 'Активные');

  const RequestFilterType({required this.value});
  final String value;
}

class RepairRequestBloc extends Bloc<RepairRequestEvent, RepairRequestState>
    with _SetStateMixin {
  RepairRequestBloc({
    required this._requestRepository,
    required this._problemRepository,
    required this._logger,
  }) : super(const .loading(requests: [], filter: .all)) {
    on<_GetRepairRequestsEvent>(
      (event, emit) => _getRequest(event, emit),
      transformer: restartable(),
    );
    on<_CreateRepairRequestsEvent>(
      (event, emit) => _create(event, emit),
      transformer: sequential(),
    );
    on<_FilterChangedEvent>((event, emit) => _filterChanged(event, emit));
  }

  final IRequestRepository _requestRepository;
  final IProblemRepository _problemRepository;
  final Logger _logger;

  Future<void> _getRequest(
    _GetRepairRequestsEvent event,
    Emitter<RepairRequestState> emit,
  ) async {
    try {
      await emit.forEach(
        _requestRepository.getRequests(
          uid: event.uid,
          specId: event.specId,
          dormId: event.dormId,
          status: event.status,
        ),
        onData: (data) => .loaded(requests: data, filter: state.filter),
        onError: (error, _) => .error(
          requests: state.requests,
          filter: state.filter,
          message: error,
        ),
      );
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(requests: state.requests, filter: state.filter, message: e));
    }
  }

  Future<void> _create(
    _CreateRepairRequestsEvent event,
    Emitter<RepairRequestState> emit,
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
    } on Object catch (e, stackTrace) {
      addError(e, stackTrace);
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(requests: state.requests, filter: state.filter, message: e));
    }
  }

  Future<void> _filterChanged(
    _FilterChangedEvent event,
    Emitter<RepairRequestState> emit,
  ) async => emit(state.copyWith(filter: event.filter));
}

mixin _SetStateMixin<State extends RepairRequestState>
    implements Emittable<State> {
  void setState(State state) => emit(state);
}
