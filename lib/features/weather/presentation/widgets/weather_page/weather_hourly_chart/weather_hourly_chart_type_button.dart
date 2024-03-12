import 'package:flutter/material.dart';
import 'package:weather_app/core/util/enums/hourly_chart_type_enum.dart';

class WeatherHourlyChartTypeButton extends StatelessWidget {
  final HourlyChartType type;
  final HourlyChartType currentType;
  final void Function()? changeType;
  const WeatherHourlyChartTypeButton({
    super.key,
    required this.type,
    required this.currentType,
    this.changeType,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: changeType != null ? () => changeType!() : null,
        child: Container(
          constraints: const BoxConstraints(minWidth: 70),
          decoration: BoxDecoration(
            color: currentType == type
                ? const Color.fromARGB(100, 0, 0, 0)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(6),
          child: Center(
            child: Text(
              type.title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}
