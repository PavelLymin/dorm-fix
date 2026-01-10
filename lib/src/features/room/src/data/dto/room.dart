import '../../../room.dart';

class RoomDto {
  const RoomDto({
    required this.id,
    required this.dormitoryId,
    required this.floor,
    required this.number,
    required this.isOccupied,
  });

  final int id;
  final int dormitoryId;
  final int floor;
  final String number;
  final bool isOccupied;

  RoomEntity toEntity() => RoomEntity(
    id: id,
    dormitoryId: dormitoryId,
    floor: floor,
    number: number,
    isOccupied: isOccupied,
  );

  factory RoomDto.fromEntity(RoomEntity entity) => RoomDto(
    id: entity.id,
    dormitoryId: entity.dormitoryId,
    floor: entity.floor,
    number: entity.number,
    isOccupied: entity.isOccupied,
  );

  factory RoomDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'dormitory_id': final int dormitoryId,
      'floor': final int floor,
      'number': final String number,
      'is_occupied': final bool isOccupied,
    }) {
      return RoomDto(
        id: id,
        dormitoryId: dormitoryId,
        floor: floor,
        number: number,
        isOccupied: isOccupied,
      );
    } else {
      throw ArgumentError('Invalid JSON format for RoomDto: $json');
    }
  }

  Map<String, Object?> toJson() => {
    'id': id,
    'dormitory_id': dormitoryId,
    'floor': floor,
    'number': number,
    'is_occupied': isOccupied,
  };
}
