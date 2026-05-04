import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:rxdart/rxdart.dart';

import '../../../material.dart';

part 'material_event.dart';
part 'material_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  MaterialBloc({required this._materialRepository, required this._logger})
    : super(.loading(materials: [], typeId: null)) {
    onQueryChanged = BehaviorSubject<String>();
    _subscription = onQueryChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) => add(.get(query: query)));
    on<MaterialEvent>((event, emit) async {
      await event.map(
        getMaterials: (e) => _getMaterials(e, emit),
        filterChanged: (e) => _filterChanged(e, emit),
      );
    });
  }

  final IMaterialRepository _materialRepository;
  final Logger _logger;

  late StreamSubscription _subscription;
  late BehaviorSubject<String> onQueryChanged;

  Future<void> _getMaterials(
    _GetMaterialsEvent e,
    Emitter<MaterialState> emit,
  ) async {
    try {
      final materials = (e.query == null || e.query!.trim().isEmpty)
          ? await _materialRepository.getMaterials()
          : await _materialRepository.getMaterials(
              query: e.query?.toLowerCase(),
            );
      emit(.loaded(materials: materials, typeId: state.typeId));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(materials: state.materials, typeId: state.typeId, error: e));
    }
  }

  Future<void> _filterChanged(
    _FilterChangedEvent event,
    Emitter<MaterialState> emit,
  ) async => emit(state.copyWith(typeId: event.typeId));

  void dispose() {
    _subscription.cancel();
    onQueryChanged.close();
  }
}
