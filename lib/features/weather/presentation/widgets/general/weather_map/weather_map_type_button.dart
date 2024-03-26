import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/util/enums/map_type_enum.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherMapTypeButton extends StatelessWidget {
  final MapType type;
  final void Function() onTap;
  const WeatherMapTypeButton({
    super.key,
    required this.onTap,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final activeType = context.select<WeatherProvider, MapType>(
      (provider) => provider.activeMapType,
    );
    return Hero(
      tag: type.title,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minWidth: 70),
            decoration: BoxDecoration(
              color: activeType == type
                  ? const Color.fromARGB(100, 0, 0, 0)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(6),
            child: Center(
              child: Text(
                type.title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
