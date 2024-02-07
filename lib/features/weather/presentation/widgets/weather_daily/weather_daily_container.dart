import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_icon.dart';

class WeatherDailyContainer extends StatefulWidget {
  final WeatherForecastDailyEntity? day;
  const WeatherDailyContainer({super.key, required this.day});

  @override
  State<WeatherDailyContainer> createState() => _WeatherDailyContainerState();
}

class _WeatherDailyContainerState extends State<WeatherDailyContainer> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: expanded
          ? Column(
              children: [
                _row(),
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      10,
                      (index) => Container(
                        height: 50,
                        margin: const EdgeInsets.only(right: 10),
                        width: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(100, 0, 0, 0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
              ],
            )
          : _row(),
    );
  }

  Widget _row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 10,
          child: Row(
            children: [
              //Expand icon
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () => setState(() => expanded = !expanded),
                icon: Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_sharp
                      : Icons.keyboard_arrow_down_sharp,
                ),
              ),
              // weekday
              Text(
                widget.day != null
                    ? DateFormat.EEEE("de").format(
                        DateTime.fromMillisecondsSinceEpoch(
                          widget.day!.dt * 1000,
                        ),
                      )
                    : "Unkown",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              // Rain
              Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    fill: widget.day?.pop ?? 0,
                    size: 8,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${((widget.day?.pop ?? 0) * 100).round().toString()}%",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Row(
                children: [
                  // Clouds
                  Icon(
                    Icons.cloud,
                    fill: ((widget.day?.clouds.toDouble() ?? 0) / 100),
                    size: 8,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${widget.day?.clouds.toString() ?? "0"}%",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Flexible(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              WeatherIcon(),
              WeatherIcon(),
            ],
          ),
        ),
        Flexible(
          flex: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${widget.day?.temp.day.round()}°C",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Text(" / "),
              Text(
                "${widget.day?.temp.eve.round()}°C",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
