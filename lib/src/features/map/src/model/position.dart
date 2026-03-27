class Position {
  const Position({
    this.latitude = 56.010543,
    this.longitude = 92.852581,
    this.zoom = 14.0,
  });

  final double latitude;
  final double longitude;
  final double zoom;

  Position copyWith({double? latitude, double? longitude, double? zoom}) =>
      Position(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        zoom: zoom ?? this.zoom,
      );

  @override
  String toString() =>
      'Position(latitude: $latitude,'
      'longitude: $longitude, '
      'zoom: $zoom)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          zoom == other.zoom;

  @override
  int get hashCode => Object.hashAll([latitude, longitude, zoom]);
}
