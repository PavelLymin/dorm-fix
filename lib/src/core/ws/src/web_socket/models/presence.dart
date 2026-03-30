part of 'payload.dart';

final class PresencePayload extends Payload {
  const PresencePayload({required this.uid, required this.isOnline});
  final String uid;
  final bool isOnline;

  @override
  Map<String, Object?> toJson() => {'uid': uid, 'is_online': isOnline};

  factory PresencePayload.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'uid': String uid,
      'is_online': bool isOnline,
    }) {
      return PresencePayload(uid: uid, isOnline: isOnline);
    }

    throw FormatException('Invalid payload for presence: $json');
  }
}
