import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_ayot/data/enums/permission_status.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';
import 'package:task_ayot/services/database/coordinate_db.dart';
import 'package:task_ayot/services/database/database_service.dart';

import '../services/location_service.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial()) {
    _init();
  }

  Future<void> _init() async {
    await requestPermission();
    getCoordinateList();
  }

  final LocationService _locationService = LocationService();
  final CoordinateDB _coordinateDB = CoordinateDB();
  late final List<CoordinateModel> _coordinateList;

  Future<void> requestPermission() async {
    PermissionStatus status = await _locationService.permission();
    // if (status == PermissionStatus.granted) periodicStream;
    emit(PermissionState(status));
  }

  Stream<CoordinateModel> get locationStream => _locationService.locationStream;

  Stream<CoordinateModel?> get periodicStream =>
      _locationService.periodicStream;

  void getCoordinateList() {
    _coordinateList = _coordinateDB.getCoordinateList();
    emit(CoordinateListState(_coordinateList));
  }

  Future<void> addCoordinate(CoordinateModel coordinate) async {
    await _coordinateDB.addCoordinate(coordinate);
    _coordinateList.add(coordinate);
    emit(CoordinateListState(_coordinateList));
  }

  @override
  Future<void> close() async {
    super.close();
    _locationService.dispose();
  }
}
