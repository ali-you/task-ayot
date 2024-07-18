import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';

class DbInitializer {
  Future<void> initHiveFlutter() async {
    await Hive.initFlutter();
  }

  Future<void> initDB() async {
    _registerAdapter();
    await _coordinate();
  }

  void _registerAdapter() {
    Hive.registerAdapter(CoordinateModelAdapter());
  }

  Future<void> _coordinate() async {
    await Hive.openBox<CoordinateModel>('CoordinateDB');
  }

}