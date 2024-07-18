import 'package:hive/hive.dart';

part 'coordinate_model.g.dart';

@HiveType(typeId: 1)
class CoordinateModel {
  @HiveField(0)
  final double latitude;
  @HiveField(2)
  final double longitude;

  CoordinateModel({this.latitude = 0, this.longitude = 0});

  @override
  String toString() {
    return 'CoordinateModel{latitude: $latitude, longitude: $longitude}';
  }

  CoordinateModel copyWith({
    double? latitude,
    double? longitude,
  }) {
    return CoordinateModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
