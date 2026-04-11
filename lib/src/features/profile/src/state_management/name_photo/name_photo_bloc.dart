import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../profile.dart';

part 'name_photo_event.dart';
part 'name_photo_state.dart';

class NamePhotoBloc extends Bloc<NamePhotoEvent, NamePhotoState> {
  NamePhotoBloc({
    required this._logger,
    required this._firebaseUserRepository,
    required this._userRepository,
  }) : super(.initial()) {
    on<NamePhotoEvent>((event, emit) async {
      await event.map(update: (e) => _update(e, emit));
    });
  }

  final Logger _logger;
  final IFirebaseUserRepository _firebaseUserRepository;
  final IUserRepository _userRepository;

  Future<void> _update(_UpdateEvent e, Emitter<NamePhotoState> emit) async {
    emit(const .loading());
    try {
      final url = e.user.photoURL;
      final path = url?.split('/').last;
      await _firebaseUserRepository.updateProfile(
        displayName: e.user.displayName,
        photoURL: path,
      );

      await _userRepository.update(user: e.user.copyWith(photoURL: path));

      if (url != null) {
        final file = File(url);
        await _userRepository.uploadAvatar(file: file, path: path!);
      }

      emit(const .success());
    } on Object catch (e, st) {
      _logger.e('Ошибка при обновлении имени и фото', error: e, stackTrace: st);
      emit(.error(message: e));
    }
  }
}
