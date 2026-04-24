part of 'master_bloc.dart';

typedef MasterEventMatch<R, E extends MasterEvent> =
    FutureOr<R> Function(E event);

sealed class MasterEvent {
  const MasterEvent();

  const factory MasterEvent.get({int? dormId, int? specId}) = _GetMastersEvent;

  FutureOr<R> map<R>({required MasterEventMatch<R, _GetMastersEvent> get}) =>
      switch (this) {
        _GetMastersEvent e => get(e),
      };
}

final class _GetMastersEvent extends MasterEvent {
  const _GetMastersEvent({this.dormId, this.specId});

  final int? dormId;
  final int? specId;
}
