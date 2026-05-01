part of 'material_bloc.dart';

typedef MaterialEventMatch<R, E extends MaterialEvent> = R Function(E event);

sealed class MaterialEvent {
  const MaterialEvent();

  factory MaterialEvent.get() = _GetMaterialsEvent;
  factory MaterialEvent.filterChanged({int? typeId}) =>
      _FilterChangedEvent(typeId: typeId);

  R map<R>({
    required MaterialEventMatch<R, _GetMaterialsEvent> getMaterials,
    required MaterialEventMatch<R, _FilterChangedEvent> filterChanged,
  }) => switch (this) {
    _GetMaterialsEvent m => getMaterials(m),
    _FilterChangedEvent f => filterChanged(f),
  };
}

final class _GetMaterialsEvent extends MaterialEvent {
  const _GetMaterialsEvent();
}

final class _FilterChangedEvent extends MaterialEvent {
  const _FilterChangedEvent({this.typeId});

  final int? typeId;
}
