import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../../core/rest_client/rest_client.dart';
import '../../data/repository/specialization_repository.dart';
import '../../model/specialization.dart';

part 'specialization_event.dart';
part 'specialization_state.dart';

class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  SpecializationBloc({
    required ISpecializationRepository specializationRepository,
    required Logger logger,
  }) : _specializationRepository = specializationRepository,
       _logger = logger,
       super(SpecializationState.loading(specializations: [])) {
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

      emit(SpecializationState.loaded(specializations: specializations));
    } on RestClientException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(
        SpecializationState.error(
          specializations: state.specializations,
          message: e.message,
        ),
      );
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(
        SpecializationState.error(
          specializations: state.specializations,
          message: e.toString(),
        ),
      );
    }
  }
}
