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

  Map<String, Object?> toJson() => {
    'id': id,
    'number': number,
    'name': name,
    'address': address,
    'long': long,
    'lat': lat,
  };

  static DormitoryDto fromJson(Map<String, Object?> json) => DormitoryDto(
    id: json['id'] as int,
    number: json['number'] as int,
    name: json['name'] as String,
    address: json['address'] as String,
    long: json['long'] as double,
    lat: json['lat'] as double,
  );
}
