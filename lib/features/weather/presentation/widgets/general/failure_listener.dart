import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather/presentation/provider/failure_provider.dart';

class FailureListener extends StatelessWidget {
  final Widget child;
  const FailureListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final failures = context.select<FailureProvider, List<Failure>>(
      (value) => value.failures,
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      addSnackbarWhenRequired(context, failures);
    });

    return child;
  }

  void addSnackbarWhenRequired(BuildContext context, List<Failure> failures) {
    if (failures.isNotEmpty) {
      for (final failure in failures) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            margin: const EdgeInsets.all(15),
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
}
