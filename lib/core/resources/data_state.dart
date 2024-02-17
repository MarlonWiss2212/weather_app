import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';

class DataState<T> extends Equatable {
  final T? data;
  final Failure? failure;

  const DataState._({
    this.data,
    this.failure,
  });

  factory DataState.success(T data, {Failure? failure}) => DataState._(
        data: data,
        failure: failure,
      );

  factory DataState.failure(Failure failure, {T? data}) => DataState._(
        failure: failure,
        data: data,
      );

  /// handle a function if one variable exists
  ///
  /// when both variables exist it will return the value of the success function
  /// when none exist it will throw a [GeneralFailure]
  D either<D>({
    required D Function(T data) onSuccess,
    required D Function(Failure failure) onError,
  }) {
    if (failure != null && (data != null || data.runtimeType == Void)) {
      onError(failure!);
      return onSuccess(data as T);
    } else if (failure != null) {
      return onError(failure!);
    } else if (data != null || data.runtimeType == Void) {
      return onSuccess(data as T);
    }
    throw const GeneralFailure(
      message:
          "Error when trying to run either function. This is an internal app failure please try again",
    );
  }

  @override
  List<Object?> get props => [failure, data];
}
