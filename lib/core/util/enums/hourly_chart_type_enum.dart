import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_clouds_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_rain_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_snow_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_temp_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_uvi_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_wind_diagram.dart';

enum HourlyChartType {
  temp,
  rain,
  snow,
  clouds,
  wind,
  uvi,
}

extension HourlyChartTypeExtension on HourlyChartType {
  String get title {
    switch (this) {
      case HourlyChartType.clouds:
        return "Wolken";
      case HourlyChartType.rain:
        return "Regen";
      case HourlyChartType.snow:
        return "Schnee";
      case HourlyChartType.temp:
        return "Temperatur";
      case HourlyChartType.wind:
        return "Wind";
      case HourlyChartType.uvi:
        return "UV-Index";
    }
  }

  WeatherHourlyDiagram getDiagram(List<WeatherForecastHourlyEntity> hourly) {
    switch (this) {
      case HourlyChartType.clouds:
        return WeatherHourlyCloudsDiagram(hourly: hourly);
      case HourlyChartType.rain:
        return WeatherHourlyRainDiagram(hourly: hourly);
      case HourlyChartType.snow:
        return WeatherHourlySnowDiagram(hourly: hourly);
      case HourlyChartType.temp:
        return WeatherHourlyTempDiagram(hourly: hourly);
      case HourlyChartType.wind:
        return WeatherHourlyWindDiagram(hourly: hourly);
      case HourlyChartType.uvi:
        return WeatherHourlyUviDiagram(hourly: hourly);
    }
  }
}
