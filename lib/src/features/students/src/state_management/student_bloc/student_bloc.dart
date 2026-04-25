import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../profile/profile.dart';
import '../../../student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc({required this._repository, required this._logger})
    : super(.initial()) {
    on<StudentEvent>((event, emit) async {
      await event.map(add: (e) => _add(e, emit));
    });
  }

  final IStudentRepository _repository;
  final Logger _logger;

  Future<void> _add(_AddStudentEvent e, Emitter<StudentState> emit) async {
    try {
      emit(.loading());
      await _repository.createStudent(student: e.student);
      emit(.loaded());
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(error: e));
    }
  }
}
