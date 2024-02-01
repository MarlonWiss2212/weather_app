import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';

class DataState<T> extends Equatable {
  final T? data;
  final Failure? failure;

  const DataState._({
    this.data,
    this.failure,
  });

  factory DataState.success(T data) => DataState._(data: data);
  factory DataState.failure(Failure failure) => DataState._(failure: failure);

  D handle<D>({
    required D Function(T data) onSuccess,
    required D Function(Failure failure) onError,
  }) {
    if (failure != null) {
      return onError(failure!);
    }
    if (data != null || data.runtimeType == Null) {
      return onSuccess(data as T);
    }
    throw const GeneralFailure();
  }

  @override
  List<Object?> get props => [failure, data];
}
