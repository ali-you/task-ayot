import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_ayot/data/enums/permission_status.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';
import 'package:task_ayot/logic/main_screen_cubit.dart';
import 'package:task_ayot/ui/screens/main_screen.dart';
import 'package:task_ayot/ui/widgets/coordinate_widget.dart';

class MockMainScreenCubit extends MockCubit<MainScreenState> implements MainScreenCubit {}

void main() {
  late MockMainScreenCubit mockMainScreenCubit;

  setUp(() {
    mockMainScreenCubit = MockMainScreenCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<MainScreenCubit>(
        create: (_) => mockMainScreenCubit,
        child: const MainScreen(),
      ),
    );
  }

  testWidgets('should display current location when permission is granted', (WidgetTester tester) async {
    when(() => mockMainScreenCubit.state).thenReturn(PermissionState(PermissionStatus.granted));
    when(() => mockMainScreenCubit.periodicStream).thenAnswer((_) => Stream.value(CoordinateModel(latitude: 37.37, longitude: 55.55)));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Your current location'), findsOneWidget);
    expect(find.text('Latitude: 37.37\nLongitude: 55.55'), findsOneWidget);
  });

  testWidgets('should display permission denied message', (WidgetTester tester) async {
    when(() => mockMainScreenCubit.state).thenReturn(PermissionState(PermissionStatus.denied));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Please grant location permission!'), findsOneWidget);
    expect(find.text('Grant permission'), findsOneWidget);
  });

  testWidgets('should display permanently denied message', (WidgetTester tester) async {
    when(() => mockMainScreenCubit.state).thenReturn(PermissionState(PermissionStatus.permanentlyDenied));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('You permanently denied location permission! change this from settings'), findsOneWidget);
    expect(find.text('Grant permission'), findsOneWidget);
  });

  testWidgets('should display list of coordinates', (WidgetTester tester) async {
    final coordinates = [
      CoordinateModel(latitude: 37.37, longitude: 55.55),
      CoordinateModel(latitude: 40.40, longitude: 11.11),
    ];
    when(() => mockMainScreenCubit.state).thenReturn(CoordinateListState(coordinates));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(CoordinateWidget), findsNWidgets(2));
    expect(find.text('Latitude: 37.37\nLongitude: 55.55'), findsOneWidget);
    expect(find.text('Latitude: 40.40\nLongitude: 11.11'), findsOneWidget);
  });

  testWidgets('should display "No item! add something!" when coordinate list is empty', (WidgetTester tester) async {
    when(() => mockMainScreenCubit.state).thenReturn(CoordinateListState([]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('No item ! add something!'), findsOneWidget);
  });
}