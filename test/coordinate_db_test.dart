import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';
import 'package:task_ayot/services/database/coordinate_db.dart';

@GenerateMocks([Box])
import 'coordinate_db_test.mocks.dart';

void main() {
  late MockBox<CoordinateModel> mockBox;
  late CoordinateDB coordinateDB;

  setUp(() {
    mockBox = MockBox<CoordinateModel>();
    coordinateDB = CoordinateDB(db: mockBox);
  });

  group('CoordinateDB', () {
    test('should add a coordinate to the database', () async {
      final coordinate = CoordinateModel(latitude: 37.37, longitude: 55.55);
      when(mockBox.add(any)).thenAnswer((_) async => 0);

      await coordinateDB.addCoordinate(coordinate);

      verify(mockBox.add(coordinate)).called(1);
    });

    test('should get a list of coordinates from the database', () async {
      final coordinateList = [
        CoordinateModel(latitude: 37.37, longitude: 55.55),
        CoordinateModel(latitude: 37.37, longitude: 55.55),
      ];
      when(mockBox.values).thenReturn(coordinateList);

      final result = coordinateDB.getCoordinateList();

      expect(result, coordinateList);
    });
  });
}