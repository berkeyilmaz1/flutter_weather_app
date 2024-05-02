import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheather_app/feature/home/view/home_view.dart';
import 'package:wheather_app/product/model/weather_model.dart';
import 'package:wheather_app/product/service/weather_service.dart';

abstract class HomeViewModel extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  final _weatherService =
      WeatherService(apiKey: "YOUR API KEY HERE");
  WeatherModel? weather;

  fetchWeather() async {
    Position position = await _weatherService.getCurrentCity();
    try {
    final getweather = await _weatherService.getWeather(position);

      setState(() {
        weather = getweather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getAnimation(String? condition) {
    if (condition == null) return "assets/lotties/loading.json";

    switch (condition.toLowerCase()) {
      case "Clear":
        return "assets/lotties/clear_sky.json";
      case "clouds":
        return "assets/lotties/scattered_clouds.json";
      case "Drizzle":
        return "assets/lotties/shower_rain.json";
      case "rain":
        return "assets/lotties/rain.json";
      case "thunderstorm":
        return "assets/lotties/thunderstorm.json";
      case "snow":
        return "assets/lotties/snow.json";
      case "mist":
        return "assets/lotties/mist.json";
      case "Fog":
        return "assets/lotties/mist.json";
      case "Smoke":
        return "assets/lotties/mist.json";
      case "Haze":
        return "assets/lotties/mist.json";
      default:
        return "assets/lotties/sunny.json";
    }
  }
}
