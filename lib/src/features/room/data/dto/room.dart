import '../../model/room.dart';

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

  static RoomDto fromEntity(RoomEntity entity) => RoomDto(
    id: entity.id,
    dormitoryId: entity.dormitoryId,
    floor: entity.floor,
    number: entity.number,
    isOccupied: entity.isOccupied,
  );

  static RoomDto fromJson(Map<String, Object?> json) => RoomDto(
    id: json['id'] as int,
    dormitoryId: json['dormitoryId'] as int,
    floor: json['floor'] as int,
    number: json['number'] as String,
    isOccupied: json['isOccupied'] as bool,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'dormitoryId': dormitoryId,
    'floor': floor,
    'number': number,
    'isOccupied': isOccupied,
  };
}
