import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../../profile/profile.dart';
import '../../data/repository/master_repository.dart';

part 'master_event.dart';
part 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  MasterBloc({required this._repository, required this._logger})
    : super(const .loading(masters: [])) {
    on<MasterEvent>((event, emit) async {
      await event.map(get: (e) => _get(e, emit));
    });
  }

  final IMasterRepository _repository;
  final Logger _logger;

  Future<void> _get(_GetMastersEvent e, Emitter<MasterState> emit) async {
    try {
      final masters = await _repository.getMasters(
        dormId: e.dormId,
        specId: e.specId,
      );
      emit(.loaded(masters: masters));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(masters: state.masters, error: e));
    }
  }
}
