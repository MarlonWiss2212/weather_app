import 'package:weather_app/core/errors/failures.dart';

class DataState<T> {
  final T? data;
  final Failure? failure;

  DataState._({
    this.data,
    this.failure,
  });

  factory DataState.success(T data) => DataState._(data: data);
  factory DataState.failure(Failure failure) => DataState._(failure: failure);

  D handle<D>({
    required D Function(T data) onSuccess,
    required D Function(Failure failure) onError,
  }) {
    if (data != null) {
      return onSuccess(data as T);
    } else {
      return onError(failure as Failure);
    }
  }
}
