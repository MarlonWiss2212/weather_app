import 'package:flutter/material.dart';
import 'package:weather_app/core/util/enums/map_type_enum.dart';

class WeatherMapTypeButton extends StatelessWidget {
  final MapType activeType;
  final MapType type;
  final void Function() onTap;
  const WeatherMapTypeButton({
    super.key,
    required this.onTap,
    required this.type,
    required this.activeType,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: type.title,
      child: Container(
        // TODO: better way for margin in future
        margin: const EdgeInsets.only(right: 8),
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
      ),
    );
  }
}
