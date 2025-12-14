import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
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

  factory DormitoryDto.fromEntity(DormitoryEntity entity) => DormitoryDto(
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

  factory DormitoryDto.fromData(Dormitory data) => DormitoryDto(
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

  factory DormitoryDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': int id,
      'number': int number,
      'name': String name,
      'address': String address,
      'long': double long,
      'lat': double lat,
    }) {
      return DormitoryDto(
        id: id,
        number: number,
        name: name,
        address: address,
        long: long,
        lat: lat,
      );
    }

    throw FormatException('Invalid JSON format for DormitoryDto', json);
  }
}
