import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_ayot/data/enums/permission_status.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';
import 'package:task_ayot/services/database/coordinate_db.dart';

import '../services/location_service.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  final LocationService locationService;
  final CoordinateDB coordinateDB;
  late final List<CoordinateModel> _coordinateList;

  MainScreenCubit({required this.locationService, required this.coordinateDB})
      : super(MainScreenInitial()) {
    _init();
  }

  Future<void> _init() async {
    await requestPermission();
    getCoordinateList();
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await locationService.permission();
    emit(PermissionState(status));
  }

  Stream<CoordinateModel> get locationStream => locationService.locationStream;

  Stream<CoordinateModel?> get periodicStream =>
      locationService.periodicStream;

  void getCoordinateList() {
    _coordinateList = coordinateDB.getCoordinateList();
    emit(CoordinateListState(_coordinateList));
  }

  Future<void> addCoordinate(CoordinateModel coordinate) async {
    await coordinateDB.addCoordinate(coordinate);
    _coordinateList.add(coordinate);
    emit(CoordinateListState(_coordinateList));
  }

  @override
  Future<void> close() async {
    super.close();
    locationService.dispose();
  }
}
