import '../../../dormitory.dart';

class DormitoryDto {
  DormitoryDto({
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'name': name,
    'address': address,
    'long': long,
    'lat': lat,
  };

  factory DormitoryDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'number': final int number,
      'name': final String name,
      'address': final String address,
      'long': final double long,
      'lat': final double lat,
    }) {
      return DormitoryDto(
        id: id,
        number: number,
        name: name,
        address: address,
        long: long,
        lat: lat,
      );
    } else {
      throw ArgumentError('Invalid JSON format for DormitoryDto: $json');
    }
  }

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
