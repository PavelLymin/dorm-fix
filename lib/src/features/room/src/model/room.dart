class RoomEntity {
  const RoomEntity({
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

  String get roomNumber => '$floor-$number';

  RoomEntity copyWith({
    int? id,
    int? dormitoryId,
    int? floor,
    String? number,
    bool? isOccupied,
  }) => RoomEntity(
    id: id ?? this.id,
    dormitoryId: dormitoryId ?? this.dormitoryId,
    floor: floor ?? this.floor,
    number: number ?? this.number,
    isOccupied: isOccupied ?? this.isOccupied,
  );

  @override
  String toString() =>
      'RoomEntity('
      'id: $id, '
      'dormitoryId: $dormitoryId, '
      'floor: $floor, '
      'number: $number, '
      'isOccupied: $isOccupied)';

  @override
  bool operator ==(Object other) => other is RoomEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
