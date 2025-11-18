class Dormitory {
  Dormitory({
    required this.id,
    required this.number,
    required this.name,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  final int id;
  final int number;
  final String name;
  final String address;
  final double longitude;
  final double latitude;

  factory Dormitory.fromJson(Map<String, dynamic> json) {
    return Dormitory(
      id: json['id'] as int,
      number: json['number'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      longitude: json['long'] as double,
      latitude: json['lat'] as double,
    );
  }

  Map<dynamic, String> toJson() {
    return {
      'id': id.toString(),
      'number': number.toString(),
      'name': name,
      'address': address,
      'long': longitude.toString(),
      'lat': latitude.toString(),
    };
  }

  @override
  String toString() {
    return 'FullBuilding($id, $number, $name, $address, $longitude, $latitude)';
  }

  @override
  bool operator ==(Object other) => other is Dormitory && other.id == id;

  @override
  int get hashCode => Object.hash(id, number, name, longitude, latitude);

  Dormitory copyWith({
    int? id,
    int? number,
    String? name,
    String? address,
    double? longitude,
    double? latitude,
  }) {
    return Dormitory(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}
