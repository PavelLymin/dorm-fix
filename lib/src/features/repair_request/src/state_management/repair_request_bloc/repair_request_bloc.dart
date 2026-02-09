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
       _webSocket = webSocket,
       _logger = logger,
       super(.loading(requests: [])) {
    _streamSubscription = _webSocket.stream.listen((data) {
      final payload = data.payload;
      if (payload is! RepairRequestResponse) return;
      final response = RepairRequestResponse.response(
        payload as RepairRequestPayload,
        state.requests,
      );
      response.map(
        created: (response) => setState(.loaded(requests: response.requests)),
        deleted: (response) => setState(.loaded(requests: response.requests)),
        updated: (response) => setState(.loaded(requests: response.requests)),
        error: (response) => setState(
          .error(requests: state.requests, message: response.message),
        ),
      );
    });
    on<RepairRequestEvent>((event, emit) async {
      await event.map(
        get: (_) => _getRequest(emit),
        create: (event) => _create(event, emit),
      );
    });
  }

  final IRequestRepository _requestRepository;
  final IWebSocket _webSocket;
  final Logger _logger;

  StreamSubscription? _streamSubscription;

  Future<void> _getRequest(Emitter<RepairRequestState> emit) async {
    try {
      final requests = await _requestRepository.getRequests();
      emit(.loaded(requests: requests));
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
      final request = event.request.toEntity();
      await _requestRepository.createRequest(request: request);
    } on ArgumentError catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(requests: state.requests, message: e.message));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(requests: state.requests, message: e));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

mixin _SetStateMixin<State extends RepairRequestState>
    implements Emittable<State> {
  void setState(State state) {
    emit(state);
  }
}
