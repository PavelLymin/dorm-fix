// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';

// import '../../data/repository/profile_repository.dart';
// import '../../model/profile.dart';

// part 'profile_event.dart';
// part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileBloc({
//     required this._logger,
//     required IProfileRepository profileRepository,
//   }) : _logger = logger,
//        _profileRepository = profileRepository,
//        super(.loading(profile: .initial())) {
//     on<ProfileEvent>((event, emit) async {
//       await event.map(
//         get: (_) => _getProfile(emit),
//         updateStudentProfile: (event) => _updateStudentProfile(event, emit),
//       );
//     });
//   }

//   final Logger _logger;
//   final IProfileRepository _profileRepository;

//   Future<void> _getProfile(Emitter<ProfileState> emit) async {
//     try {
//       final profile = await _profileRepository.getProfile();
//       profile.map(
//         student: (profile) => emit(.loadedStudent(student: profile)),
//         master: (profile) => emit(.loadedMaster(master: profile)),
//       );
//     } on Object catch (e, stackTrace) {
//       _logger.e(e, stackTrace: stackTrace);
//       emit(.error(profile: state.currentProfile, message: e));
//     }
//   }

//   Future<void> _updateStudentProfile(
//     _UpdateStudentProfileEvent event,
//     Emitter<ProfileState> emit,
//   ) async {}
// }
