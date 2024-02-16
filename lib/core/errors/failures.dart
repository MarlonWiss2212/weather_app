import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final String errorMessage;

  const Failure({required this.errorMessage, this.statusCode});
}

// Server failures

class ServerFailure extends Failure {
  ServerFailure({required DioException error})
      : super(
          errorMessage: error.message ?? "",
          statusCode: error.response?.statusCode,
        );

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class NoAPIResponseFailure extends Failure {
  const NoAPIResponseFailure({
    super.errorMessage = "The API didn't return any data",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

// location failures

class LocationPermissionDenied extends Failure {
  const LocationPermissionDenied({
    super.errorMessage =
        "The location permission is denied. Please open the app settings to enable them.",
  });

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class LocationPermissionDeniedForever extends Failure {
  const LocationPermissionDeniedForever({
    super.errorMessage =
        "The location permission is denied forever. Please open the app settings to enable them.",
  });

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class LocationPermissionUnableToDetermine extends Failure {
  const LocationPermissionUnableToDetermine({
    super.errorMessage =
        "The location permission is unable to determine. Please open the app settings to enable them.",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class LocationServiceNotEnabledFailure extends Failure {
  const LocationServiceNotEnabledFailure({
    super.errorMessage =
        "The location service is disabled please enable it in your device settings first.",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class LocationTimeoutFailure extends Failure {
  const LocationTimeoutFailure({
    super.errorMessage = "Your device did not return any location data",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

// Setting failures

class OpeningAppSettingsFailure extends Failure {
  const OpeningAppSettingsFailure({
    super.errorMessage = "Failure opening the app settings.",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class OpeningLocationSettingsFailure extends Failure {
  const OpeningLocationSettingsFailure({
    super.errorMessage = "Failure opening the location settings.",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class ConvertingFailure extends Failure {
  const ConvertingFailure({
    super.errorMessage =
        "The App has an error converting data we will try to fix it soon",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class GeneralFailure extends Failure {
  const GeneralFailure({
    super.errorMessage =
        "The app has a general failure we will try to fix it soon",
  });
  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class UnkownFailure extends Failure {
  const UnkownFailure({super.errorMessage = "Unknown failure"});

  @override
  List<Object?> get props => [errorMessage, statusCode];
}
