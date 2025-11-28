import 'dart:async';

import '../data/repository/settings_repository.dart';
import '../model/settings.dart';

abstract interface class SettingsService {
  Stream<SettingsEntity> get stream;

  SettingsEntity get current;

  Future<void> update(
    SettingsEntity Function(SettingsEntity current) transform,
  );
}

final class SettingsServiceImpl implements SettingsService {
  SettingsServiceImpl._(this._repository, this._current);

  static Future<SettingsServiceImpl> create({
    required ISettingsRepository repository,
  }) async {
    final current = await repository.read();
    return SettingsServiceImpl._(repository, current);
  }

  final ISettingsRepository _repository;
  final _controller = StreamController<SettingsEntity>.broadcast();
  SettingsEntity _current;

  @override
  Stream<SettingsEntity> get stream => _controller.stream;

  @override
  SettingsEntity get current => _current;

  @override
  Future<void> update(SettingsEntity Function(SettingsEntity) transform) async {
    final updated = transform(current);
    await _repository.save(updated);
    _current = updated;
    _controller.add(updated);
  }
}
