import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../dormitory/dormitory.dart';

part 'pins_event.dart';
part 'pins_state.dart';

class PinsBloc extends Bloc<PinsEvent, PinsState> {
  PinsBloc({required this._dormitoryRepository, required this._logger})
    : super(PinsState.loading(dormitories: [])) {
    on<PinsEvent>(
      (event, emit) async =>
          await event.map(get: (e) => _getDormitories(e, emit)),
    );
  }

  final IDormitoryRepository _dormitoryRepository;
  final Logger _logger;

  Future<void> _getDormitories(PinsEvent event, Emitter<PinsState> emit) async {
    emit(PinsState.loading(dormitories: []));
    try {
      final dormitories = await _dormitoryRepository.getDormitories();
      emit(PinsState.loaded(dormitories: dormitories));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(
        PinsState.error(dormitories: state.dormitories, message: e.toString()),
      );
    }
  }
}
