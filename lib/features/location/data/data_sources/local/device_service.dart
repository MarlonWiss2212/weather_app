import 'package:geolocator/geolocator.dart';

abstract class DeviceService {
  ///Opens the App settings page.
  ///Returns [true] if the location settings page could be opened, otherwise [false] is returned.
  Future<bool> openAppSettings();

  /// Opens the location settings page.
  ///
  /// Returns [true] if the location settings page could be opened, otherwise [false] is returned.
  Future<bool> openLocationSettings();
}

class DeviceServiceImpl implements DeviceService {
  @override
  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  @override
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }
}
