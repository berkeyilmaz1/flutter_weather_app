class ForecastModel {
  int? temp;
  int? feelsLike;
  int? humidity;
  String? mainCondition;
  String? description;
  String? cityName;
  int? wind;
  int? date;

  ForecastModel(
      {this.temp,
      this.feelsLike,
      this.humidity,
      this.mainCondition,
      this.description,
      this.cityName,
      this.wind,
      this.date});

  ForecastModel.fromJson(Map<String, dynamic> json) {
    temp = json['main']?['temp']?.toInt();
    feelsLike = json['main']?['feels_like']?.toInt();
    humidity = json['main']?['humidity']?.toInt();
    mainCondition = (json['weather'] as List?)?.isNotEmpty ?? false
        ? json['weather'][0]['main']
        : null;
    description = (json['weather'] as List?)?.isNotEmpty ?? false
        ? json['weather'][0]['description']
        : null;
    wind = json['wind']?['speed']?.toInt();
    date = json['dt']?.toInt();
  }
}
