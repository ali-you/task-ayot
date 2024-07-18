import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:task_ayot/data/enums/permission_status.dart';
import 'package:task_ayot/data/models/coordinate_model.dart';

class LocationService {
  final StreamController<CoordinateModel?> _controller =
      StreamController<CoordinateModel?>();
  Timer? _timer;

  final GeolocatorPlatform _locatorPlatform = GeolocatorPlatform.instance;
  final LocationSettings _locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, distanceFilter: 100);

  Future<CoordinateModel> currentLocation() async {
    Position position = await _locatorPlatform.getCurrentPosition();

    return CoordinateModel(
        latitude: position.latitude, longitude: position.longitude);
  }

  /// on change position
  Stream<CoordinateModel> get locationStream =>
      Geolocator.getPositionStream(locationSettings: _locationSettings).map(
          (position) => CoordinateModel(
              latitude: position.latitude, longitude: position.longitude));

  _initTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        _controller.add(null);
        var loc = await currentLocation();
        _controller.add(loc);
      },
    );
  }

  Stream<CoordinateModel?> get periodicStream {
    _timer?.cancel();
    _initTimer();
    return _controller.stream;
  }

  Future<PermissionStatus> permission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _locatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return PermissionStatus.unableToDetermine;
    }

    permission = await _locatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _locatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return PermissionStatus.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _openAppSettings();
      return PermissionStatus.permanentlyDenied;
    }
    return PermissionStatus.granted;
  }

  void _openAppSettings() async {
    final opened = await _locatorPlatform.openAppSettings();
    String displayValue;
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
