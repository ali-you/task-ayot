part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}

final class PermissionState extends MainScreenState {
  final PermissionStatus status;

  PermissionState(this.status);
}

final class CoordinateListState extends MainScreenState {
  final List<CoordinateModel> coordinateList;

  CoordinateListState(this.coordinateList);
}


