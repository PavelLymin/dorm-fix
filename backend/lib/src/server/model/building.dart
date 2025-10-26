class BuildingEntity {
  const BuildingEntity({
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

  BuildingEntity copyWith({
    int? id,
    int? number,
    String? name,
    String? address,
    double? long,
    double? lat,
  }) => BuildingEntity(
    id: id ?? this.id,
    number: number ?? this.number,
    name: name ?? this.name,
    address: address ?? this.address,
    long: long ?? this.long,
    lat: lat ?? this.lat,
  );

  @override
  String toString() =>
      'BuildingEntity('
      'id: $id, '
      'number: $number, '
      'name: $name, '
      'address: $address, '
      'long: $long, '
      'lat: $lat)';

  @override
  bool operator ==(Object other) => other is BuildingEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
