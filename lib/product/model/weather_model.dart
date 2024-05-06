class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final double wind;
  final double humidity;
  final double feelsLike;

  WeatherModel(
      {required this.cityName,
      required this.description,
      required this.temperature,
      required this.mainCondition,
      required this.wind,
      required this.humidity,
      required this.feelsLike});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      wind: json['wind']['speed'].toDouble(),
    );
  }
}
