import 'package:weather_app/core/errors/failures.dart';
import 'package:flutter/widgets.dart';

/// Provides function and the failures of the app
class FailureProvider extends ChangeNotifier {
  List<Failure> _failures = [];

  List<Failure> get failures {
    final List<Failure> failures = _failures;
    resetFailures();
    return failures;
  }

  void resetFailures() {
    _failures = [];
  }

  void addFailureToList(Failure failure) {
    _failures.add(failure);
    notifyListeners();
  }
}
