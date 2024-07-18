part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}

final class PermissionState extends MainScreenState {
  final PermissionStatus status;

  PermissionState(this.status);
}


