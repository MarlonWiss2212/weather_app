import 'package:weather_app/core/errors/failures.dart';

abstract class DataState<T> {
  final T? data;
  final Failure? error;

  const DataState({this.data, this.error});

  bool get isSuccess => data != null;
  bool get isFailed => error != null;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Failure error) : super(error: error);
}
