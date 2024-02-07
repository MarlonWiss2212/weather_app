import 'package:equatable/equatable.dart';

/// Geodata found by (lat, lon) location
class ReverseGeocodingEntity extends Equatable {
  /// Name of the found location
  final String name;

  /// different locale names of the found location
  ///
  /// [language code]: Name of the found location in different languages. The list of names can be different for different locations.
  ///
  /// ascii: Internal field
  ///
  /// feature_name Internal field
  final Map<String, String> localNames;

  /// Geographical coordinates of the found location (latitude)
  final double lat;

  /// Geographical coordinates of the found location (longitude)
  final double lon;

  /// Country of the found location
  final String country;

  /// (where available) State of the found location
  final String? state;

  const ReverseGeocodingEntity({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  @override
  List<Object?> get props => [name, localNames, lat, lon, country, state];
}
