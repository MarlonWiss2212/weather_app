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
        child: widget.day != null
            ? Hero(
                tag: widget.day!.weekday + widget.day!.dt.toString(),
                child: weekdayTextWidget(),
              )
            : weekdayTextWidget(),
      );

  Widget weekdayTextWidget() => Text(
        widget.day?.weekday ?? "Unknown",
        style: Theme.of(context).textTheme.bodyLarge,
        overflow: TextOverflow.ellipsis,
      );

  Widget iconsWithRainWidgetAndDegrees() => Flexible(
        flex: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _rainWidget(),
            Expanded(
              flex: 5,
              child: widget.day?.weather[0] != null
                  ? WeatherIcon(
                      iconCode: widget.day!.weather[0].icon,
                      snow: widget.day!.temp.day < 0,
                    )
                  : const SizedBox(),
            ),
            _degreeWidget(),
          ],
        ),
      );

  Widget _rainWidget() => Expanded(
        flex: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Rain
            Icon(
              (widget.day?.temp.day ?? 10) > 0
                  ? Icons.water_drop_rounded
                  : Icons.snowing,
              fill: widget.day?.pop ?? 0,
              size: 8,
            ),
            const SizedBox(width: 5),
            Text(
              "${((widget.day?.pop ?? 0) * 100).round().toString()}%",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      );

  Widget _degreeWidget() => Expanded(
        flex: 5,
        child: Hero(
          tag: "DailyTemp${widget.day?.dt}",
          child: Text(
            "${widget.day?.temp.max.round()}°C / ${widget.day?.temp.min.round()}°C",
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.end,
          ),
        ),
      );
}
