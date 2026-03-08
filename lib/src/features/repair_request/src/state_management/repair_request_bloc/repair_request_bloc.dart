import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../../../core/ws/ws.dart';
import '../../../request.dart';
import '../request_form_bloc/request_form_model.dart';

part 'repair_request_event.dart';
part 'repair_request_state.dart';

class RepairRequestBloc extends Bloc<RepairRequestEvent, RepairRequestState>
    with _SetStateMixin {
  RepairRequestBloc({
    required IRequestRepository requestRepository,
    required IWebSocket webSocket,
    required Logger logger,
  }) : _requestRepository = requestRepository,
       _logger = logger,
       super(const .loading(requests: [])) {
    on<RepairRequestEvent>((event, emit) async {
      await event.map(
        get: (_) => _getRequest(emit),
        create: (event) => _create(event, emit),
      );
    });
  }

  final IRequestRepository _requestRepository;
  final Logger _logger;

  Future<void> _getRequest(Emitter<RepairRequestState> emit) async {
    // try {
    //   final requests = await _requestRepository.getRequests();
    //   emit(.loaded(requests: requests));
    // } on Object catch (e, stackTrace) {
    //   _logger.e(e, stackTrace: stackTrace);
    //   emit(.error(requests: state.requests, message: e));
    // }
  }

  Future<void> _create(
    _CreateRepairRequestsEvent event,
    Emitter<RepairRequestState> emit,
  ) async {
    try {
      final request = event.request.toEntity();
      await _requestRepository.createRequest(request: request);
    } on Object catch (e, stackTrace) {
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
