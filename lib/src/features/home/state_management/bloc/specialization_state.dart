part of 'specialization_bloc.dart';

typedef SpecializationStateMatch<R, S extends SpecializationState> =
    R Function(S state);

sealed class SpecializationState {
  const SpecializationState({this.specializations = const []});

  final List<SpecializationEntity> specializations;

  const factory SpecializationState.loading({
    required List<SpecializationEntity> specializations,
  }) = _SpecializationLoading;
  const factory SpecializationState.loaded({
    required List<SpecializationEntity> specializations,
  }) = _SpecializationLoaded;
  const factory SpecializationState.error({
    required List<SpecializationEntity> specializations,
    required String message,
  }) = _SpecializationError;

  R map<R>({
    // ignore: library_private_types_in_public_api
    required SpecializationStateMatch<R, _SpecializationLoading> loading,
    // ignore: library_private_types_in_public_api
    required SpecializationStateMatch<R, _SpecializationLoaded> loaded,
    // ignore: library_private_types_in_public_api
    required SpecializationStateMatch<R, _SpecializationError> error,
  }) => switch (this) {
    _SpecializationLoading s => loading(s),
    _SpecializationLoaded s => loaded(s),
    _SpecializationError s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    // ignore: library_private_types_in_public_api
    SpecializationStateMatch<R, _SpecializationLoading>? loading,
    // ignore: library_private_types_in_public_api
    SpecializationStateMatch<R, _SpecializationLoaded>? loaded,
    // ignore: library_private_types_in_public_api
    SpecializationStateMatch<R, _SpecializationError>? error,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    // ignore: library_private_types_in_public_api
    SpecializationStateMatch<R, _SpecializationLoading>? loading,
    // ignore: library_private_types_in_public_api
    SpecializationStateMatch<R, _SpecializationLoaded>? loaded,
    // ignore: library_private_types_in_public_api
    SpecializationStateMatch<R, _SpecializationError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _SpecializationLoading extends SpecializationState {
  const _SpecializationLoading({required super.specializations});
}

final class _SpecializationLoaded extends SpecializationState {
  const _SpecializationLoaded({required super.specializations});
}

final class _SpecializationError extends SpecializationState {
  const _SpecializationError({
    required super.specializations,
    required this.message,
  });

  final String message;
}
