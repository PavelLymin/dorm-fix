part of 'material_type_bloc.dart';

typedef MaterialTypeStateMatch<R, S extends MaterialTypeState> =
    R Function(S state);

sealed class MaterialTypeState {
  const MaterialTypeState({this.materialTypes = const [], this.typeId});

  final List<MaterialTypeEntity> materialTypes;
  final int? typeId;

  const factory MaterialTypeState.loading({
    required List<MaterialTypeEntity> materialTypes,
    int? typeId,
  }) = _MaterialTypeLoading;
  const factory MaterialTypeState.loaded({
    required List<MaterialTypeEntity> materialTypes,
    int? typeId,
  }) = _MaterialTypeLoaded;
  const factory MaterialTypeState.error({
    required List<MaterialTypeEntity> materialTypes,
    int? typeId,
    required Object message,
  }) = _MaterialTypeError;

  R map<R>({
    required MaterialTypeStateMatch<R, _MaterialTypeLoading> loading,
    required MaterialTypeStateMatch<R, _MaterialTypeLoaded> loaded,
    required MaterialTypeStateMatch<R, _MaterialTypeError> error,
  }) => switch (this) {
    _MaterialTypeLoading s => loading(s),
    _MaterialTypeLoaded s => loaded(s),
    _MaterialTypeError s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    MaterialTypeStateMatch<R, _MaterialTypeLoading>? loading,
    MaterialTypeStateMatch<R, _MaterialTypeLoaded>? loaded,
    MaterialTypeStateMatch<R, _MaterialTypeError>? error,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    MaterialTypeStateMatch<R, _MaterialTypeLoading>? loading,
    MaterialTypeStateMatch<R, _MaterialTypeLoaded>? loaded,
    MaterialTypeStateMatch<R, _MaterialTypeError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _MaterialTypeLoading extends MaterialTypeState {
  const _MaterialTypeLoading({required super.materialTypes, super.typeId});
}

final class _MaterialTypeLoaded extends MaterialTypeState {
  const _MaterialTypeLoaded({required super.materialTypes, super.typeId});
}

final class _MaterialTypeError extends MaterialTypeState {
  const _MaterialTypeError({
    required super.materialTypes,
    super.typeId,
    required this.message,
  });

  final Object message;
}
