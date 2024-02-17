class _ExceptionWithMessage implements Exception {
  final String? message;
  _ExceptionWithMessage({this.message});
}

class NoAPIResponseException implements Exception {}

class ConvertingException extends _ExceptionWithMessage {
  ConvertingException({super.message});
}

class GeneralException extends _ExceptionWithMessage {
  GeneralException({super.message});
}
