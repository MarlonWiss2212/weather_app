enum ChartType { temp, rain, clouds, snow, wind }

extension ChartTypeExtension on ChartType {
  String get title {
    switch (this) {
      case ChartType.clouds:
        return "Wolken";
      case ChartType.rain:
        return "Regen";
      case ChartType.temp:
        return "Temperatur";
      case ChartType.snow:
        return "Schnee";
      case ChartType.wind:
        return "Wind";
    }
  }
}
