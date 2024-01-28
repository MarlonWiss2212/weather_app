import 'package:dio/dio.dart';

abstract class Failure {
  final int? statusCode;
  final String errorMessage;

  Failure({required this.errorMessage, this.statusCode});
}

class NoAPIResponseFailure extends Failure {
  NoAPIResponseFailure()
      : super(
          errorMessage: "The API didn't return any data",
        );
}

class ServerFailure extends Failure {
  ServerFailure({required DioException error})
      : super(
          errorMessage: error.message ?? "",
          statusCode: error.response?.statusCode,
        );
}
