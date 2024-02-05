enum ChartType { temp, rain, clouds }

extension ChartTypeExtension on ChartType {
  String get title {
    switch (this) {
      case ChartType.clouds:
        return "Wolken";
      case ChartType.rain:
        return "Regen";
      case ChartType.temp:
        return "Temperatur";
    }
  }
}
