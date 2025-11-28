part of 'pins_bloc.dart';

typedef PinsStateMatch<R, S extends PinsState> = R Function(S state);

sealed class PinsState {
  const PinsState({required this.dormitories});
  final List<DormitoryEntity> dormitories;

  const factory PinsState.loading({
    required List<DormitoryEntity> dormitories,
  }) = _PinsStateLoading;

  const factory PinsState.loaded({required List<DormitoryEntity> dormitories}) =
      _PinsStateLoaded;

  const factory PinsState.error({
    required List<DormitoryEntity> dormitories,
    required String message,
  }) = _ErrorStateLoaded;

  R map<R>({
    required PinsStateMatch<R, _PinsStateLoading> loading,
    required PinsStateMatch<R, _PinsStateLoaded> loaded,
    required PinsStateMatch<R, _ErrorStateLoaded> error,
  }) => switch (this) {
    _PinsStateLoading s => loading(s),
    _PinsStateLoaded s => loaded(s),
    _ErrorStateLoaded s => error(s),
  };

  R maybeMap<R>({
    PinsStateMatch<R, _PinsStateLoading>? loading,
    PinsStateMatch<R, _PinsStateLoaded>? loaded,
    PinsStateMatch<R, _ErrorStateLoaded>? error,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    PinsStateMatch<R, _PinsStateLoading>? loading,
    PinsStateMatch<R, _PinsStateLoaded>? loaded,
    PinsStateMatch<R, _ErrorStateLoaded>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _PinsStateLoading extends PinsState {
  const _PinsStateLoading({required super.dormitories});
}

final class _PinsStateLoaded extends PinsState {
  const _PinsStateLoaded({required super.dormitories});
}

final class _ErrorStateLoaded extends PinsState {
  const _ErrorStateLoaded({required super.dormitories, required this.message});
  final String message;
}
