sealed class Dormitory {
  const Dormitory();

  const factory Dormitory.full({
    required String id,
    required String number,
    required String name,
    required String address,
    required String latitude,
    required String longitude,
  }) = FullDormitory;
}

class FullDormitory extends Dormitory {
  const FullDormitory({
    required this.id,
    required this.number,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String number;
  final String name;
  final String address;
  final String latitude;
  final String longitude;

  factory FullDormitory.fromJson(Map<String, dynamic> json) {
    return FullDormitory(
      id: json['id'] as String,
      number: json['number'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map<dynamic, String> toJson() {
    return {
      'id': id,
      'number': number,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return 'FullBuilding($id, $number, $name, $address, $latitude, $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FullDormitory &&
        other.id == id &&
        other.number == number &&
        other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return Object.hash(id, number, name, latitude, longitude);
  }

  FullDormitory copyWith({
    String? id,
    String? number,
    String? name,
    String? address,
    String? latitude,
    String? longitude,
  }) {
    return FullDormitory(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
