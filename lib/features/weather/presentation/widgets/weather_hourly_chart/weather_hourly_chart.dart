import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly_chart/chart_type.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly_chart/weather_hourly_chart_diagram.dart';

class WeatherHourlyChart extends StatefulWidget {
  const WeatherHourlyChart({super.key});

  @override
  State<WeatherHourlyChart> createState() => _WeatherHourlyChartState();
}

class _WeatherHourlyChartState extends State<WeatherHourlyChart> {
  ChartType type = ChartType.temp;

  @override
  Widget build(BuildContext context) {
    final hourly =
        context.select<WeatherProvider, List<WeatherForecastHourlyEntity>?>(
      (provider) => provider.weather?.hourly,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );
    final showSkeleton = loading && hourly == null;

    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: showSkeleton,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  ChartType.values.length,
                  (index) => _chartTypeButton(
                    ChartType.values[index],
                  ),
                ),
              ),
            ),
            Expanded(
              child: WeatherHourlyChartDiagram(
                hourly: hourly != null
                    ? hourly.length > 24
                        ? hourly.getRange(0, 24).toList()
                        : hourly
                    : [],
                type: type,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartTypeButton(ChartType type) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => setState(() => this.type = type),
          child: Container(
            decoration: BoxDecoration(
              color: this.type == type
                  ? const Color.fromARGB(100, 0, 0, 0)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                type.title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
