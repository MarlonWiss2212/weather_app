import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_alert_entity.dart';

class WeatherAlertBox extends StatelessWidget {
  final WeatherForecastAlertEntity alert;
  const WeatherAlertBox({
    super.key,
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                alert.event,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Text(
              """${DateFormat.yMd("de").add_Hm().format(
                    DateTime.fromMillisecondsSinceEpoch(
                      alert.start * 1000,
                    ),
                  ).toString()}-\n${DateFormat.yMd("de").add_Hm().format(
                    DateTime.fromMillisecondsSinceEpoch(
                      alert.end * 1000,
                    ),
                  ).toString()}""",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        Text(
          alert.description,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
