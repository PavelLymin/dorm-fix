import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../dormitory.dart';

part 'dormitory_event.dart';
part 'dormitory_state.dart';

class DormitoryBloc extends Bloc<DormitoryEvent, DormitoryState> {
  DormitoryBloc({required this._dormitoryRepository, required this._logger})
    : super(const .loading(dormitories: [])) {
    on<DormitoryEvent>((event, emit) async {
      await event.map(get: (_) => _getDormitories(emit));
    });
  }

  final IDormitoryRepository _dormitoryRepository;
  final Logger _logger;

  Future<void> _getDormitories(Emitter<DormitoryState> emit) async {
    emit(.loading(dormitories: state.dormitories));
    try {
      final dormitories = await _dormitoryRepository.getDormitories();
      emit(.loaded(dormitories: dormitories));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(dormitories: state.dormitories, message: e));
    }
  }
}
