class UserEntity {
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String photoURL;

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    String? photoURL,
  }) => UserEntity(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    photoURL: photoURL ?? this.photoURL,
  );

  @override
  String toString() =>
      'UserEntity('
      'uid: $uid, '
      'name: $name, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'photoURL: $photoURL)';

  @override
  bool operator ==(Object other) => other is UserEntity && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

class DormitoryEntity {
  const DormitoryEntity({
    required this.id,
    required this.number,
    required this.name,
    required this.address,
    required this.long,
    required this.lat,
  });

  final int id;
  final int number;
  final String name;
  final String address;
  final double long;
  final double lat;

  DormitoryEntity copyWith({
    int? id,
    int? number,
    String? name,
    String? address,
    double? long,
    double? lat,
  }) => DormitoryEntity(
    id: id ?? this.id,
    number: number ?? this.number,
    name: name ?? this.name,
    address: address ?? this.address,
    long: long ?? this.long,
    lat: lat ?? this.lat,
  );

  @override
  String toString() =>
      'DormitoryEntity('
      'id: $id, '
      'number: $number, '
      'name: $name, '
      'address: $address, '
      'long: $long, '
      'lat: $lat)';

  @override
  bool operator ==(Object other) => other is DormitoryEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
