import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';

import '../../../../material.dart';

part 'material_type_event.dart';
part 'material_type_state.dart';

class MaterialTypeBloc extends Bloc<MaterialTypeEvent, MaterialTypeState> {
  MaterialTypeBloc({
    required this._materialTypeRepository,
    required this._logger,
  }) : super(.loading(materialTypes: [])) {
    on<MaterialTypeEvent>((event, emit) async {
      await event.map(getMaterialTypes: (e) => _getMaterialTypes(e, emit));
    });
  }

  final IMaterialTypeRepository _materialTypeRepository;
  final Logger _logger;

  Future<void> _getMaterialTypes(
    _GetMaterialTypesEvent e,
    Emitter<MaterialTypeState> emit,
  ) async {
    try {
      final materialTypes = await _materialTypeRepository.getMaterialTypes();
      emit(.loaded(materialTypes: materialTypes));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(materialTypes: state.materialTypes, message: e));
    }
  }
}
