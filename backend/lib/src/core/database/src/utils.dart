import 'package:drift/drift.dart';

Value<T> toValue<T>(T? value) {
  return value != null ? Value(value) : const Value.absent();
}
