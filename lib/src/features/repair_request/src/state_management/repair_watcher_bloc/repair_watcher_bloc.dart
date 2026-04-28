import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../request.dart';

part 'repair_watcher_event.dart';
part 'repair_watcher_state.dart';

enum RequestFilterType {
  all(value: 'Все'),
  active(value: 'Активные');

  const RequestFilterType({required this.value});
  final String value;
}

class RepairWatcherBloc extends Bloc<RepairWatcherEvent, RepairWatcherState> {
  RepairWatcherBloc({required this._requestRepository, required this._logger})
    : super(.loading(requests: [], filter: .all)) {
    on<_GetRepairRequestsEvent>(
      (event, emit) => _getRequest(event, emit),
      transformer: restartable(),
    );
    on<_FilterChangedEvent>((event, emit) => _filterChanged(event, emit));
  }

  final IRequestRepository _requestRepository;
  final Logger _logger;

  Future<void> _getRequest(
    _GetRepairRequestsEvent event,
    Emitter<RepairWatcherState> emit,
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

  Future<void> _filterChanged(
    _FilterChangedEvent event,
    Emitter<RepairWatcherState> emit,
  ) async => emit(state.copyWith(filter: event.filter));
}
