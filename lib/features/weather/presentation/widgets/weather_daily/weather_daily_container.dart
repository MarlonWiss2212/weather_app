import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/util/uv_utils.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dailyBasicData(),
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _uviWidget(uvindex: widget.day?.uvi ?? 0),
                      const SizedBox(width: 5),
                      _snowWidget(snow: widget.day?.snow ?? 0),
                      const SizedBox(width: 5),
                      _humidityWidget(humidity: widget.day?.humidity ?? 0),
                      const SizedBox(width: 5),
                      _windWidget(
                        windDeg: widget.day?.windDeg ?? 0,
                        windSpeed: widget.day?.windSpeed ?? 0,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
              ],
            )
          : _dailyBasicData(),
    );
  }

  Widget _windWidget({
    required int windDeg,
    required double windSpeed,
  }) {
    return _extendedPartContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.air,
                size: 14,
              ),
              const SizedBox(width: 2),
              Transform.rotate(
                angle: (windDeg - 90) * (pi / 180),
                child: const Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 14,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "Wind",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            "${windSpeed.round().toString()} m/s",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _humidityWidget({required int humidity}) {
    return _extendedPartContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.water_drop,
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                "Feuchtigkeit",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            "${humidity.round().toString()} %",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _snowWidget({required double snow}) {
    return _extendedPartContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.snowing,
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                "Schnee",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            "${snow.round().toString()} mm",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _uviWidget({required double uvindex}) {
    return _extendedPartContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.sunny,
                size: 10,
              ),
              const SizedBox(width: 5),
              Text(
                "UVI",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            UvUtils.uvIndex(uvindex),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _extendedPartContainer({required Widget child}) {
    return Container(
      height: 50,
      constraints: const BoxConstraints(minWidth: 50),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget _dailyBasicData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 3,
          child: Row(
            children: [
              //Expand icon
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () => setState(() => expanded = !expanded),
                icon: Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
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
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    // Clouds
                    Row(
                      children: [
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WeatherIcon(),
                  WeatherIcon(),
                ],
              ),
              Expanded(
                flex: 4,
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
          ),
        )
      ],
    );
  }
}
