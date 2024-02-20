enum MapType {
  temp,
  precipitation,
  clouds,
  windSpeed,
}

extension MapTypeExtension on MapType {
  String get title => switch (this) {
        MapType.clouds => "Wolken",
        MapType.temp => "Temperatur",
        MapType.precipitation => "Regen",
        MapType.windSpeed => "Wind",
      };

  String get weatherMapKey => switch (this) {
        MapType.clouds => "clouds_new",
        MapType.temp => "temp_new",
        MapType.precipitation => "precipitation_new",
        MapType.windSpeed => "wind_new",
      };
}
