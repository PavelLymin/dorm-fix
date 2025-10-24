import '../../model/building.dart';

class BuildingDto {
  const BuildingDto({
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

  BuildingEntity toEntity() => BuildingEntity(
    id: id,
    number: number,
    name: name,
    address: address,
    long: long,
    lat: lat,
  );

  static BuildingDto fromEntity(BuildingEntity entity) => BuildingDto(
    id: entity.id,
    number: entity.number,
    name: entity.name,
    address: entity.address,
    long: entity.long,
    lat: entity.lat,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'name': name,
    'address': address,
    'long': long,
    'lat': lat,
  };

  static BuildingDto fromJson(Map<String, dynamic> json) => BuildingDto(
    id: json['id'],
    number: json['number'],
    name: json['name'],
    address: json['address'],
    long: json['long'],
    lat: json['lat'],
  );

  @override
  String toString() =>
      'BuildingDto('
      'id: $id, '
      'number: $number, '
      'name: $name, '
      'address: $address, '
      'long: $long, '
      'lat: $lat)';
}
