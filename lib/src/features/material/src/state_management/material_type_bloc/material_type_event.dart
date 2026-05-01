part of 'material_type_bloc.dart';

typedef MaterialTypeEventMatch<R, E extends MaterialTypeEvent> =
    R Function(E event);

sealed class MaterialTypeEvent {
  const MaterialTypeEvent();

  factory MaterialTypeEvent.get() => const _GetMaterialTypesEvent();

  factory MaterialTypeEvent.filterChanged({int? typeId}) =>
      _FilterChangedEvent(typeId: typeId);

  R map<R>({
    required MaterialTypeEventMatch<R, _GetMaterialTypesEvent> getMaterialTypes,
    required MaterialTypeEventMatch<R, _FilterChangedEvent> filterChanged,
  }) => switch (this) {
    _GetMaterialTypesEvent m => getMaterialTypes(m),
    _FilterChangedEvent f => filterChanged(f),
  };
}

final class _GetMaterialTypesEvent extends MaterialTypeEvent {
  const _GetMaterialTypesEvent();
}

final class _FilterChangedEvent extends MaterialTypeEvent {
  const _FilterChangedEvent({this.typeId});

  final int? typeId;
}
