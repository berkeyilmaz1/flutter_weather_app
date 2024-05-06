import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/feature/home/shared/styles/text_styles.dart';
import 'package:wheather_app/feature/home/view/home_view.dart';
import 'package:wheather_app/product/model/forecast_model.dart';
import 'package:wheather_app/product/model/weather_model.dart';
import 'package:wheather_app/product/service/weather_service.dart';

abstract class HomeViewModel extends State<HomeView> {
  ///forecast items
  List<ForecastModel>? items;
  final baseUrl = "https://api.openweathermap.org/data/2.5/forecast";

  @override
  void initState() {
    super.initState();
    fetchWeather();
    getWeatherData();
  }

  ///Current Weather
  final _weatherService =
      WeatherService(apiKey: "Y O U R - A P I - K E Y - H E R E");
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

    switch (condition) {
      case "Clear":
        return "assets/lotties/clear_sky.json";
      case "Clouds":
        return "assets/lotties/scattered_clouds.json";
      case "Drizzle":
        return "assets/lotties/shower_rain.json";
      case "Rain":
        return "assets/lotties/rain.json";
      case "Thunderstorm":
        return "assets/lotties/thunderstorm.json";
      case "Snow":
        return "assets/lotties/snow.json";
      case "Mist":
        return "assets/lotties/mist.json";
      case "Fog":
        return "assets/lotties/mist.json";
      case "Smoke":
        return "assets/lotties/mist.json";
      case "Haze":
        return "assets/lotties/mist.json";
      default:
        return "assets/lotties/clear_sky.json";
    }
  }

  ///Forecast
  Future<void> getWeatherData() async {
    try {
      final response = await Dio().get(

          "$baseUrl?q=Duzce&appid=-- Y O U R - A P I - K E Y - H E R E--&units=metric");

      if (response.statusCode == 200) {
        final datas = response.data['list'] as List;
        final cityName = response.data['city']['name'];
        setState(() {
          items = datas.map((dynamic json) {
            var forecastModel = ForecastModel.fromJson(json);
            forecastModel.cityName = cityName;
            return forecastModel;
          }).toList();
        });
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  Widget timeChanger(int? date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date! * 1000);
    var formattedDate = DateFormat('d MMMM').format(dateTime); //tarih
    var formattedTime = DateFormat.jm().format(dateTime); // saat

    String shortTime = formatTime(formattedTime);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(shortTime, style: forecastTimeDateDegreeStyle),
        Text(
          formattedDate,
          style: forecastTimeDateDegreeStyle,
        )
      ],
    );
  }

  String formatTime(String time) {
    String shortTime = time.replaceAllMapped(RegExp(r':\d+'), (match) => '');
    return shortTime;
  }
}
