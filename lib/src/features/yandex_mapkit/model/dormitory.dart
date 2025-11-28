class DormitoryEntity {
  DormitoryEntity({
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
  }) {
    return DormitoryEntity(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      address: address ?? this.address,
      long: long ?? this.long,
      lat: lat ?? this.lat,
    );
  }

  @override
  String toString() =>
      'DormitoryEntity('
      'id: $id, '
      'number: $number, '
      'name: $name, '
      'address: $address, '
      'longitude: $long, '
      'latitude: $lat)';

  @override
  bool operator ==(Object other) => other is DormitoryEntity && other.id == id;

  @override
  int get hashCode => Object.hash(id, number, name, long, lat);
}
