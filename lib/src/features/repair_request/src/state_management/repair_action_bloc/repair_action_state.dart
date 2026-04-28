part of 'repair_action_bloc.dart';

typedef RepairActionStateMatch<R, S extends RepairActionState> =
    R Function(S state);

sealed class RepairActionState {
  const RepairActionState();

  const factory RepairActionState.initial() = _RepairActionInitial;

  const factory RepairActionState.success() = _RepairActionSuccess;

  const factory RepairActionState.error({required Object message}) =
      _RepairActionError;

  R map<R>({
    required RepairActionStateMatch<R, _RepairActionInitial> initial,
    required RepairActionStateMatch<R, _RepairActionSuccess> success,
    required RepairActionStateMatch<R, _RepairActionError> error,
  }) => switch (this) {
    _RepairActionInitial s => initial(s),
    _RepairActionSuccess s => success(s),
    _RepairActionError s => error(s),
  };

  R maybeMap<R>({
    RepairActionStateMatch<R, _RepairActionInitial>? initial,
    RepairActionStateMatch<R, _RepairActionSuccess>? success,
    RepairActionStateMatch<R, _RepairActionError>? error,
    required R Function(RepairActionState) orElse,
  }) => map<R>(
    initial: initial ?? orElse,
    success: success ?? orElse,
    error: error ?? orElse,
  );

  R? mapOrNull<R>({
    RepairActionStateMatch<R, _RepairActionInitial>? initial,
    RepairActionStateMatch<R, _RepairActionSuccess>? success,
    RepairActionStateMatch<R, _RepairActionError>? error,
  }) => map<R?>(
    initial: initial ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _RepairActionInitial extends RepairActionState {
  const _RepairActionInitial();
}

final class _RepairActionSuccess extends RepairActionState {
  const _RepairActionSuccess();
}

final class _RepairActionError extends RepairActionState {
  const _RepairActionError({required this.message});

  final Object message;
}
