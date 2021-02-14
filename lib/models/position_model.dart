class PositionModel {
  final double longitude;
  final double latitude;

  PositionModel({this.longitude, this.latitude});

  PositionModel copyWith(PositionModel po) {
    return PositionModel(
      longitude: po.longitude ?? this.longitude,
      latitude: po.latitude ?? this.latitude,
    );
  }
}
