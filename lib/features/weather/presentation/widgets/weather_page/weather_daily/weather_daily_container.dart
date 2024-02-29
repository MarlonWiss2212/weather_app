import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_icon.dart';

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
    return InkWell(
      onTap: () => context.push("/daily", extra: widget.day),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          weekdayWidget(),
          iconsWithRainWidgetAndDegrees(),
        ],
      ),
    );
  }

  Widget weekdayWidget() => Flexible(
        flex: 2,
        child: Text(
          widget.day?.weekday ?? "Unkown",
          style: Theme.of(context).textTheme.labelLarge,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget iconsWithRainWidgetAndDegrees() => Flexible(
        flex: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _rainWidget(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WeatherIcon(),
                WeatherIcon(),
              ],
            ),
            _degreeWidget(),
          ],
        ),
      );

  Widget _rainWidget() => Flexible(
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
      );

  Widget _degreeWidget() => Flexible(
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
      );
}
