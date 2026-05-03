part of 'instruction_bloc.dart';

typedef InstructionStateMatch<R, S extends InstructionState> =
    R Function(S state);

sealed class InstructionState {
  const InstructionState({this.instructions = const []});

  final List<InstructionEntity> instructions;

  const factory InstructionState.loading({
    required List<InstructionEntity> instructions,
  }) = _InstructionLoading;
  const factory InstructionState.loaded({
    required List<InstructionEntity> instructions,
  }) = _InstructionLoaded;
  const factory InstructionState.error({
    required List<InstructionEntity> instructions,
    required Object error,
  }) = _InstructionError;

  R map<R>({
    required InstructionStateMatch<R, _InstructionLoading> loading,
    required InstructionStateMatch<R, _InstructionLoaded> loaded,
    required InstructionStateMatch<R, _InstructionError> error,
  }) => switch (this) {
    _InstructionLoading s => loading(s),
    _InstructionLoaded s => loaded(s),
    _InstructionError s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    InstructionStateMatch<R, _InstructionLoading>? loading,
    InstructionStateMatch<R, _InstructionLoaded>? loaded,
    InstructionStateMatch<R, _InstructionError>? error,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    InstructionStateMatch<R, _InstructionLoading>? loading,
    InstructionStateMatch<R, _InstructionLoaded>? loaded,
    InstructionStateMatch<R, _InstructionError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );

  @override
  String toString() => 'InstructionState(instructions: $instructions)';
}

final class _InstructionLoading extends InstructionState {
  const _InstructionLoading({required super.instructions});
}

final class _InstructionLoaded extends InstructionState {
  const _InstructionLoaded({required super.instructions});
}

final class _InstructionError extends InstructionState {
  const _InstructionError({required super.instructions, required this.error});

  final Object error;
}
