import 'package:dio/dio.dart';

abstract class Failure {
  final int? statusCode;
  final String errorMessage;

  Failure({required this.errorMessage, this.statusCode});
}

// Server failures

class ServerFailure extends Failure {
  ServerFailure({required DioException error})
      : super(
          errorMessage: error.message ?? "",
          statusCode: error.response?.statusCode,
        );
}

class NoAPIResponseFailure extends Failure {
  NoAPIResponseFailure()
      : super(
          errorMessage: "The API didn't return any data",
        );
}

// location failures

class LocationPermissionDenied extends Failure {
  LocationPermissionDenied()
      : super(
          errorMessage:
              "The location permission is denied. Please open the app settings to enable them.",
        );
}

class LocationPermissionDeniedForever extends Failure {
  LocationPermissionDeniedForever()
      : super(
          errorMessage:
              "The location permission is denied forever. Please open the app settings to enable them.",
        );
}

class LocationPermissionUnableToDetermine extends Failure {
  LocationPermissionUnableToDetermine()
      : super(
          errorMessage:
              "The location permission is unable to determine. Please open the app settings to enable them.",
        );
}

class LocationServiceNotEnabledFailure extends Failure {
  LocationServiceNotEnabledFailure()
      : super(
          errorMessage:
              "The location service is disabled please enable it in your device settings first.",
        );
}

class LocationTimeoutFailure extends Failure {
  LocationTimeoutFailure()
      : super(
          errorMessage: "Your device did not return any location data",
        );
}

// Setting failures

class OpeningAppSettingsFailure extends Failure {
  OpeningAppSettingsFailure()
      : super(
          errorMessage: "Failure opening the app settings.",
        );
}

class OpeningLocationSettingsFailure extends Failure {
  OpeningLocationSettingsFailure()
      : super(
          errorMessage: "Failure opening the location settings.",
        );
}

class ConvertingFailure extends Failure {
  ConvertingFailure()
      : super(
          errorMessage:
              "The App has an error converting data we will try to fix it soon",
        );
}

class GeneralFailure extends Failure {
  GeneralFailure()
      : super(
          errorMessage:
              "The App has a general failure we will try to fix it soon",
        );
}

class UnkownFailure extends Failure {
  UnkownFailure() : super(errorMessage: "Unkown failure");
}
