import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import '../../ws.dart';

final _jsonUTF8 = json.fuse(utf8);

abstract interface class IWebSocket {
  WebSocket get socket;

  Stream<MessageEnvelope> get stream;

  Future<void> connect(Map<String, Object?>? headers);

  Future<void> close({int code, String? reason});

  void send(String type, Map<String, Object?> payload);
}

class WebSocketBase implements IWebSocket {
  WebSocketBase({required this.uri});
  final String uri;

  WebSocket? _socket;
  StreamSubscription? _subscription;
  final _controller = StreamController<MessageEnvelope>.broadcast();

  @override
  WebSocket get socket {
    if (_socket == null) throw Exception('Not connected');
    return _socket!;
  }

  @override
  Stream<MessageEnvelope> get stream => _controller.stream;

  @override
  Future<void> connect(Map<String, Object?>? headers) async {
    if (_socket != null) return;
    try {
      _socket = await WebSocket.connect(uri, headers: headers);

      _subscription = _socket?.listen(
        _onRawMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: true,
      );
    } catch (_) {
      _onDone();
      rethrow;
    }
  }

  @override
  void send(String type, Map<String, Object?> payload) {
    final envelope = MessageEnvelope(type: type, payload: payload);
    final json = jsonEncode(envelope.toJson());

    if (_socket == null) throw Exception();

    _socket!.add(json);
  }

  @override
  Future<void> close({int code = 1000, String? reason}) async {
    try {
      await _subscription?.cancel();

      await _socket?.close(code, reason);
    } on Object catch (_) {
      rethrow;
    }
  }

  Future<void> _onRawMessage(dynamic raw) async {
    try {
      final envelope = await _decodeRaw(raw);
      _controller.add(envelope);
    } on Object {
      rethrow;
    }
  }

  void _onError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  void _onDone() {
    _socket?.close();
    _subscription?.cancel();
  }

  Future<MessageEnvelope> _decodeRaw(Object? raw) async {
    if (raw == null) throw Exception('Received null from socket');

    if (raw is String) {
      final map = await _decodeString(raw);
      return MessageEnvelope.fromJson(map);
    }

    if (raw is List<int>) {
      final map = await _decodeBytes(raw);
      return MessageEnvelope.fromJson(map);
    }

    if (raw is Map<String, Object?>) {
      return MessageEnvelope.fromJson(raw);
    }

    throw Exception('Unsupported message type: \${raw.runtimeType}');
  }

  Future<Map<String, Object?>> _decodeString(String stringBody) async {
    if (stringBody.isEmpty) return <String, Object?>{};

    if (stringBody.length > 1000) {
      final decoded = await compute(
        _parseJsonString,
        stringBody,
        debugLabel: kDebugMode ? 'WS Decode String' : null,
      );
      return decoded;
    }

    return _parseJsonString(stringBody);
  }

  Future<Map<String, Object?>> _decodeBytes(List<int> bytesBody) async {
    if (bytesBody.isEmpty) return <String, Object?>{};

    if (bytesBody.length > 1000) {
      final decoded = await compute(
        _parseJsonBytes,
        bytesBody,
        debugLabel: kDebugMode ? 'WS Decode Bytes' : null,
      );
      return decoded!;
    }

    return _parseJsonBytes(bytesBody)!;
  }
}

Map<String, Object?> _parseJsonString(String s) =>
    jsonDecode(s) as Map<String, Object?>;

Map<String, Object?>? _parseJsonBytes(List<int> bytes) =>
    _jsonUTF8.decode(bytes) as Map<String, Object?>?;
