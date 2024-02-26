import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/util/uv_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_icon.dart';

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
                    children: AnimateList(
                      interval: const Duration(milliseconds: 40),
                      effects: [
                        const FadeEffect(duration: Duration(milliseconds: 150)),
                        const ScaleEffect(
                          duration: Duration(milliseconds: 100),
                          begin: Offset(.5, .5),
                          end: Offset(1, 1),
                        )
                      ],
                      children: [
                        _cloudWidget(
                          clouds: widget.day?.clouds.toDouble() ?? 0,
                        ),
                        const SizedBox(width: 5),
                        _uviWidget(uvindex: widget.day?.uvi ?? 0),
                        if (widget.day?.snow != null) ...{
                          const SizedBox(width: 5),
                          _snowWidget(snow: widget.day?.snow ?? 0),
                        },
                        const SizedBox(width: 5),
                        _rainWidget(rain: widget.day?.rain ?? 0),
                        const SizedBox(width: 5),
                        _humidityWidget(humidity: widget.day?.humidity ?? 0),
                        const SizedBox(width: 5),
                        _windWidget(
                          windDeg: widget.day?.windDeg,
                          windSpeed: widget.day?.windSpeed ?? 0,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : _dailyBasicData(),
    );
  }

  Widget _windWidget({
    int? windDeg,
    required double windSpeed,
  }) {
    final angle = windDeg != null ? windDeg * (pi / 180) : null;
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
              if (angle != null) ...{
                Transform.rotate(
                  angle: angle,
                  child: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    size: 14,
                  ),
                ),
              },
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
                Icons.water_drop_rounded,
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

  Widget _rainWidget({required double rain}) {
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
                "Regen",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            "${rain.round().toString()} mm",
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

  Widget _cloudWidget({required double clouds}) {
    return _extendedPartContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.cloud,
                fill: clouds / 100,
                size: 10,
              ),
              const SizedBox(width: 5),
              Text(
                "Wolken",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            "${clouds.round().toString()} %",
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
                isSelected: expanded,
                padding: const EdgeInsets.all(0),
                onPressed: () => setState(() => expanded = !expanded),
                selectedIcon: const Icon(Icons.keyboard_arrow_up_rounded)
                    .animate()
                    .rotate(
                      begin: .5,
                      end: 0,
                      duration: const Duration(milliseconds: 100),
                    ),
                icon: const Icon(Icons.keyboard_arrow_down_rounded)
                    .animate()
                    .rotate(
                      begin: -.5,
                      end: 0,
                      duration: const Duration(milliseconds: 100),
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
              Flexible(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Rain
                    Icon(
                      Icons.water_drop_rounded,
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
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WeatherIcon(),
                  WeatherIcon(),
                ],
              ),
              Flexible(
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
