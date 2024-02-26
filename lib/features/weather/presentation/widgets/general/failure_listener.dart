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
    final failures = Provider.of<FailureProvider>(context).failures;
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
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            elevation: 10,
            backgroundColor: Colors.red,
            content: failure.statusCode != null
                ? Column(
                    children: [
                      Text(
                        failure.statusCode!.toString(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      errorMessage(context, failure),
                    ],
                  )
                : errorMessage(context, failure),
          ),
        );
      }
    }
  }

  Widget errorMessage(BuildContext context, Failure failure) => Text(
        failure.errorMessage,
        style: Theme.of(context).textTheme.bodyMedium,
      );
}
