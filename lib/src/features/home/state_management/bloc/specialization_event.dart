part of 'specialization_bloc.dart';

typedef SpecializationEventMatch<R, E extends SpecializationEvent> =
    R Function(E event);

sealed class SpecializationEvent {
  const SpecializationEvent();

  factory SpecializationEvent.getSpecializations() =>
      const _GetSpecializationsEvent();

  R map<R>({
    // ignore: library_private_types_in_public_api
    required SpecializationEventMatch<R, _GetSpecializationsEvent>
    getSpecializations,
  }) => switch (this) {
    _GetSpecializationsEvent s => getSpecializations(s),
  };
}

final class _GetSpecializationsEvent extends SpecializationEvent {
  const _GetSpecializationsEvent();
}
