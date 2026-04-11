part of 'name_photo_bloc.dart';

typedef NamePhotoEventMatch<R, E extends NamePhotoEvent> = R Function(E event);

sealed class NamePhotoEvent {
  const NamePhotoEvent();

  const factory NamePhotoEvent.update({required FirebaseUser user}) =
      _UpdateEvent;

  R map<R>({required NamePhotoEventMatch<R, _UpdateEvent> update}) =>
      switch (this) {
        _UpdateEvent e => update(e),
      };
}

final class _UpdateEvent extends NamePhotoEvent {
  const _UpdateEvent({required this.user});

  final FirebaseUser user;
}
