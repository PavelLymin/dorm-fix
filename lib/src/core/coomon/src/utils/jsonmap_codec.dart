import 'dart:convert';

abstract class JsonMapCodec<T> extends Codec<T, Map<String, Object?>> {
  const JsonMapCodec();

  ({T? decoded, Object? error, StackTrace? stackTrace}) tryDecode(
    Map<String, Object?> input,
  ) {
    try {
      return (decoded: $decode(input), error: null, stackTrace: null);
    } catch (e, stackTrace) {
      return (decoded: null, error: e, stackTrace: stackTrace);
    }
  }

  T $decode(Map<String, Object?> input);
  Map<String, Object?> $encode(T input);

  @override
  Converter<Map<String, Object?>, T> get decoder =>
      _FuncConverter<Map<String, Object?>, T>($decode);

  @override
  Converter<T, Map<String, Object?>> get encoder =>
      _FuncConverter<T, Map<String, Object?>>($encode);
}

class _FuncConverter<S, T> extends Converter<S, T> {
  const _FuncConverter(this._onConvert);

  final T Function(S) _onConvert;

  @override
  T convert(S input) => _onConvert(input);
}
