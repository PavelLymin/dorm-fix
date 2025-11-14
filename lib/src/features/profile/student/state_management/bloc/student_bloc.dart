import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../data/repository/student_repository.dart';
import '../../model/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc({
    required IStudentRepository studentRepository,
    required Logger logger,
  }) : _studentRepository = studentRepository,
       _logger = logger,
       super(StudentState.loading()) {
    on<StudentEvent>((event, emit) async {
      await event.match(get: (e) => _getSudent(e, emit));
    });
  }

  final IStudentRepository _studentRepository;
  final Logger _logger;

  Future<void> _getSudent(_StudentGet e, Emitter<StudentState> emit) async {
    try {
      final student = await _studentRepository.getStudent(uid: e.uid);

      emit(StudentState.loaded(student: student));
    } on RestClientException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(StudentState.error(student: state.student, message: e.message));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(StudentState.error(student: state.student, message: e.toString()));
    }
  }
}
