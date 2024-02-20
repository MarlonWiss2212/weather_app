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
}
