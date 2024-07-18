import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';
import 'package:task_ayot/ui/widgets/coordinate_widget.dart';  // Adjust the import path based on your project structure

void main() {
  testWidgets('CoordinateWidget displays placeholder text when coordinateModel is null', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CoordinateWidget(),
        ),
      ),
    );

    expect(find.text('Latitude: __.__\nLongitude: __.__'), findsOneWidget);
  });

  testWidgets('CoordinateWidget displays correct coordinates', (WidgetTester tester) async {
    final coordinateModel = CoordinateModel(latitude: 37.37, longitude: 55.55);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CoordinateWidget(coordinateModel: coordinateModel),
        ),
      ),
    );

    expect(find.text('Latitude: 37.37\nLongitude: 55.55'), findsOneWidget);
  });

  testWidgets('CoordinateWidget shows CircularProgressIndicator when refreshMode is true', (WidgetTester tester) async {
    final coordinateModel = CoordinateModel(latitude: 37.37, longitude: 55.55);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CoordinateWidget(coordinateModel: coordinateModel, refreshMode: true),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Latitude: 37.37\nLongitude: 55.55'), findsOneWidget);
  });
}