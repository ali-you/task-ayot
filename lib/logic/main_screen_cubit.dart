import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_ayot/data/enums/permission_status.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';

import '../services/location_service.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial()) {
    requestPermission();
  }

  late final LocationService _locationService =  LocationService();
  StreamSubscription<CoordinateModel>? _subscription;

  Future<void> requestPermission() async {
    PermissionStatus status = await _locationService.permission();
    // if (status == PermissionStatus.granted) periodicStream;
    emit(PermissionState(status));
  }

  Stream<CoordinateModel> get locationStream => _locationService.locationStream;

  Stream<CoordinateModel?> get periodicStream =>
      _locationService.periodicStream;

  @override
  Future<void> close() async {
    super.close();
    _locationService.dispose();
  }
}
