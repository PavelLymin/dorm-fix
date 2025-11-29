import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../core/rest_client/rest_client.dart';
import '../../data/repository/profile_repository.dart';
import '../../data/repository/student_repository.dart';
import '../../model/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required Logger logger,
    required IProfileRepository profileRepository,
    required IStudentRepository studentRepository,
  }) : _logger = logger,
       _profileRepository = profileRepository,
       _studentRepository = studentRepository,
       super(ProfileState.loading(profile: ProfileEntity.empty())) {
    on<ProfileEvent>((event, emit) async {
      await event.map(
        get: (_) => _getProfile(emit),
        updateStudentProfile: (event) => _updateStudentProfile(event, emit),
      );
    });
  }

  final Logger _logger;
  final IProfileRepository _profileRepository;
  final IStudentRepository _studentRepository;

  Future<void> runSafe(
    Emitter<ProfileState> emit,
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

  Future<void> _getProfile(Emitter<ProfileState> emit) async {
    await runSafe(emit, () async {
      final profile = await _profileRepository.getProfile();
      profile.map(
        student: (profile) =>
            emit(ProfileState.loadedStudent(student: profile)),
        master: (profile) => emit(ProfileState.loadedMaster(master: profile)),
      );
    });
  }

  Future<void> _updateStudentProfile(
    _UpdateStudentProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await runSafe(emit, () async {
      await _studentRepository.updateUserProfile(student: event.student);
      add(ProfileEvent.get());
    });
  }

  void _emitError(Emitter<ProfileState> emit, String e) =>
      emit(ProfileState.error(profile: state.currentProfile, message: e));
}
