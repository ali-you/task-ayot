import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';

class CoordinateDB {
  final Box _db;

  /// db field in constructor as for testing, dont use this through the app
  CoordinateDB({Box<CoordinateModel>? db})
      : _db = db ?? Hive.box<CoordinateModel>("CoordinateDB");

  Future<void> addCoordinate(CoordinateModel coordinate) async {
    await _db.add(coordinate);
  }

  List<CoordinateModel> getCoordinateList() {
    List<CoordinateModel> res = _db.values.toList() as List<CoordinateModel>;
    return res;
  }
}
