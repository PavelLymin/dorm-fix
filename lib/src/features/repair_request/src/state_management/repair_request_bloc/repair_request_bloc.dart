import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../request.dart';
import '../../data/repository/problem_repository.dart';
import '../request_form_bloc/request_form_model.dart';

part 'repair_request_event.dart';
part 'repair_request_state.dart';

class RepairRequestBloc extends Bloc<RepairRequestEvent, RepairRequestState>
    with _SetStateMixin {
  RepairRequestBloc({
    required this._requestRepository,
    required this._problemRepository,
    required this._logger,
  }) : super(const .loading(requests: [])) {
    on<RepairRequestEvent>((event, emit) async {
      await event.map(
        get: (event) => _getRequest(event, emit),
        create: (event) => _create(event, emit),
      );
    }, transformer: droppable());
  }

  final IRequestRepository _requestRepository;
  final IProblemRepository _problemRepository;
  final Logger _logger;

  Future<void> _getRequest(
    _GetRepairRequestsEvent event,
    Emitter<RepairRequestState> emit,
  ) async {
    try {
      StreamSubscription? subscription;

      subscription = _requestRepository
          .getRequests(
            uid: event.uid,
            specId: event.specId,
            dormId: event.dormId,
            status: event.status,
          )
          .listen((requests) {
            emit(.loaded(requests: requests));
          }, onDone: () => subscription?.cancel());
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(requests: state.requests, message: e));
    }
  }

  Future<void> _create(
    _CreateRepairRequestsEvent event,
    Emitter<RepairRequestState> emit,
  ) async {
    try {
      log(event.request.problems.toString());
      final request = event.request.toEntity();
      final newRequest = await _requestRepository.createRequest(
        request: request,
      );

      await _problemRepository.uploadProblems(
        problems: newRequest.problems,
        requestId: newRequest.id,
      );
    } on Object catch (e, stackTrace) {
      addError(e, stackTrace);
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(requests: state.requests, message: e));
    }
  }
}

mixin _SetStateMixin<State extends RepairRequestState>
    implements Emittable<State> {
  void setState(State state) {
    emit(state);
  }
}
