part of 'material_bloc.dart';

typedef MaterialStateMatch<R, S extends MaterialState> = R Function(S state);

sealed class MaterialState {
  const MaterialState({this.materials = const [], this._typeId});

  final List<MaterialEntity> materials;
  final int? _typeId;

  int? get typeId {
    if (_typeId != null && _typeId < 1) return null;

    return _typeId;
  }

  const factory MaterialState.loading({
    required List<MaterialEntity> materials,
    int? typeId,
  }) = _MaterialLoading;
  const factory MaterialState.loaded({
    required List<MaterialEntity> materials,
    int? typeId,
  }) = _MaterialLoaded;
  const factory MaterialState.error({
    required List<MaterialEntity> materials,
    int? typeId,
    required Object error,
  }) = _MaterialError;

  R map<R>({
    required MaterialStateMatch<R, _MaterialLoading> loading,
    required MaterialStateMatch<R, _MaterialLoaded> loaded,
    required MaterialStateMatch<R, _MaterialError> error,
  }) => switch (this) {
    _MaterialLoading s => loading(s),
    _MaterialLoaded s => loaded(s),
    _MaterialError s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    MaterialStateMatch<R, _MaterialLoading>? loading,
    MaterialStateMatch<R, _MaterialLoaded>? loaded,
    MaterialStateMatch<R, _MaterialError>? error,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    MaterialStateMatch<R, _MaterialLoading>? loading,
    MaterialStateMatch<R, _MaterialLoaded>? loaded,
    MaterialStateMatch<R, _MaterialError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );

  List<MaterialEntity> get filteredMaterials => switch (typeId) {
    null => materials,
    0 => materials,
    _ => materials.where((material) => material.type.id == typeId).toList(),
  };

  MaterialState copyWith({List<MaterialEntity>? materials, int? typeId}) =>
      switch (this) {
        _MaterialLoading _ => MaterialState.loading(
          materials: materials ?? this.materials,
          typeId: typeId ?? this.typeId,
        ),
        _MaterialLoaded _ => MaterialState.loaded(
          materials: materials ?? this.materials,
          typeId: typeId ?? this.typeId,
        ),
        _MaterialError _ => MaterialState.error(
          materials: materials ?? this.materials,
          typeId: typeId ?? this.typeId,
          error: (this as _MaterialError).error,
        ),
      };

  @override
  String toString() => 'MaterialState(materials: $materials, typeId: $typeId)';
}

final class _MaterialLoading extends MaterialState {
  const _MaterialLoading({required super.materials, super.typeId});
}

final class _MaterialLoaded extends MaterialState {
  const _MaterialLoaded({required super.materials, super.typeId});
}

final class _MaterialError extends MaterialState {
  const _MaterialError({
    required super.materials,
    super.typeId,
    required this.error,
  });

  final Object error;
}
