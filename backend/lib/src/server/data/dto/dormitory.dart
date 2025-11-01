import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';
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

  DormitoriesCompanion toCompanion() => DormitoriesCompanion(
    id: Value(id),
    number: Value(number),
    name: Value(name),
    address: Value(address),
    long: Value(long),
    lat: Value(lat),
  );

  static DormitoryDto fromData(Dormitory data) => DormitoryDto(
    id: data.id,
    number: data.number,
    name: data.name,
    address: data.address,
    long: data.long,
    lat: data.lat,
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

  @override
  bool operator ==(Object other) => other is DormitoryDto && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
