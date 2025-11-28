abstract base class PersistedColumn<T extends Object> {
  const PersistedColumn();

  Future<T?> read();

  Future<void> set(T value);

  Future<void> remove();

  Future<void> setIfNullRemove(T? value) =>
      value == null ? remove() : set(value);
}
