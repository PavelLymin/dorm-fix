import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../specialization.dart';

part 'specialization_event.dart';
part 'specialization_state.dart';

class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  SpecializationBloc({
    required this._specializationRepository,
    required this._logger,
  }) : super(SpecializationState.loading(specializations: [])) {
    on<SpecializationEvent>((event, emit) async {
      await event.map(getSpecializations: (e) => _getSpecializations(e, emit));
    });
  }

  final ISpecializationRepository _specializationRepository;
  final Logger _logger;

  Future<void> _getSpecializations(
    _GetSpecializationsEvent e,
    Emitter<SpecializationState> emit,
  ) async {
    try {
      final specializations = await _specializationRepository
          .getSpecializations();
      emit(.loaded(specializations: specializations));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(specializations: state.specializations, message: e));
    }
  }
}
