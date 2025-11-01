import '../../model/dormitory.dart';

class DormitoryDto {
  const DormitoryDto({
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

  DormitoryEntity toEntity() => DormitoryEntity(
    id: id,
    number: number,
    name: name,
    address: address,
    long: long,
    lat: lat,
  );

  static DormitoryDto fromEntity(DormitoryEntity entity) => DormitoryDto(
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

  static DormitoryDto fromJson(Map<String, dynamic> json) => DormitoryDto(
    id: json['id'],
    number: json['number'],
    name: json['name'],
    address: json['address'],
    long: json['long'],
    lat: json['lat'],
  );

  @override
  String toString() =>
      'DormitoryDto('
      'id: $id, '
      'number: $number, '
      'name: $name, '
      'address: $address, '
      'long: $long, '
      'lat: $lat)';
}
