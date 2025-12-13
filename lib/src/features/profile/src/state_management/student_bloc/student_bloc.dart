import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../core/rest_client/rest_client.dart';
import '../../data/repository/student_repository.dart';
import '../../model/profile.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc({
    required Logger logger,
    required IStudentRepository studentRepository,
  }) : _logger = logger,
       _studentRepository = studentRepository,
       super(StudentState.loading()) {
    on<StudentEvent>((event, emit) async {
      await event.map(create: (event) => _createStudent(event, emit));
    });
  }

  final Logger _logger;
  final IStudentRepository _studentRepository;

  Future<void> runSafe(
    Emitter<StudentState> emit,
    Future<void> Function() body,
  ) async {
    try {
      await body();
    } on StructuredBackendException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      _emitError(emit, e.message);
    } on RestClientException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      _emitError(emit, e.message);
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      _emitError(emit, e.toString());
    }
  }

  Future<void> _createStudent(
    _StudentCreateStudent event,
    Emitter<StudentState> emit,
  ) async {
    await runSafe(emit, () async {
      await _studentRepository.createStudent(student: event.student);
      emit(StudentState.created());
    });
  }

  void _emitError(Emitter<StudentState> emit, String e) =>
      emit(StudentState.error(message: e));
}
