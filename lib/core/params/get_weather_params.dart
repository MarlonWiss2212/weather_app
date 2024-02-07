import 'package:equatable/equatable.dart';

class GetWeatherParams extends Equatable {
  /// Your unique API key (you can always find it on your account page under the "API key" tab [https://home.openweathermap.org/api_keys])
  final String appid;

  /// By using this parameter you can exclude some parts of the weather data from the API response. It should be a comma-delimited list (without spaces).
  /// Available values:
  /// current
  /// minutely
  /// hourly
  /// daily
  /// alerts
  final String? exclude;

  /// Units of measurement. standard, metric and imperial units are available. If you do not use the units parameter, standard units will be applied by default. Learn more [https://openweathermap.org/api/one-call-3#data]
  final String? units;

  /// You can use the lang parameter to get the output in your language. Learn more [https://openweathermap.org/api/one-call-3#multi]
  final String? lang;

  const GetWeatherParams({
    required this.appid,
    this.exclude,
    this.units,
    this.lang,
  });

  @override
  List<Object?> get props => [appid, exclude, units, lang];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'appid': appid,
    };
    if (exclude != null) {
      map['exclude'] = exclude;
    }
    if (units != null) {
      map['units'] = units;
    }
    if (lang != null) {
      map['lang'] = lang;
    }

    return map;
  }
}
