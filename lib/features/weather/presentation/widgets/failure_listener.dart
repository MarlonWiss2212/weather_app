import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather/presentation/provider/failure_provider.dart';

class FailureListener extends StatelessWidget {
  final Widget child;
  const FailureListener({
    super.key,
    required this.child,
  });

  void listenToFailureState(BuildContext context) {
    final failures = Provider.of<FailureProvider>(
      context,
      listen: true,
    ).failures;
    addSnackbarWhenRequired(context, failures);
  }

  void addSnackbarWhenRequired(BuildContext context, List<Failure> failures) {
    if (failures.isNotEmpty) {
      for (final failure in failures) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: failure.statusCode != null
                ? Column(
                    children: [
                      Text(failure.statusCode!.toString()),
                      errorMessage(failure),
                    ],
                  )
                : errorMessage(failure),
          ),
        );
      }
    }
  }

  Widget errorMessage(Failure failure) => Text(failure.errorMessage);

  @override
  Widget build(BuildContext context) {
    listenToFailureState(context);
    return child;
  }
}
