import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather_app/feature/home/shared/styles/text_styles.dart';
import 'package:wheather_app/feature/home/view_model/home_viewmodel.dart';
import 'package:wheather_app/product/utility/components/icon_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  String cityError = "City Name Not Found";
  String conditionError = "Condition Not Found";
  String descriptionError = "Description Not Found";
  String subtitleTemp = "Feels Like";
  String subtitleHumidity = "Humidity";
  String subtitleWind = "Wind Speed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              animationCreator(),
              degreeShower(),
              const SizedBox(
                height: 20,
              ),
              conditions(),
              const SizedBox(
                height: 80,
              ),
              otherProperties()
            ],
          ),
        ));
  }

  Row otherProperties() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconCard(
                  data: "${weather?.feelsLike} °C",
                  icon: Icons.thermostat_outlined,
                  subtitle: subtitleTemp,
                ),
                IconCard(
                  data: "${weather?.humidity} %",
                  icon: Icons.water_drop_outlined,
                  subtitle: subtitleHumidity,
                ),
                IconCard(
                  data: "${weather?.wind} km/h",
                  icon: Icons.air_outlined,
                  subtitle: subtitleWind,
                ),
              ],
            );
  }

  RichText degreeShower() {
    return RichText(
              text: TextSpan(
                text: "${weather?.temperature.round()}",
                style: tempStyle,
                children: const <TextSpan>[
                  TextSpan(text: "°C", style: celciusStyle),
                ],
              ),
            );
  }

  AppBar appBar() {
    return AppBar(
        title: Text(
          weather?.cityName ?? cityError,
          style: appTitle,
        ),
        centerTitle: true,
      );
  }

  Column conditions() {
    return Column(
      children: [
        Text(
          weather?.mainCondition ?? conditionError,
          style: conditionStyle,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(weather?.description ?? descriptionError,
            style: conditionSubtitleStyle),
      ],
    );
  }

  LottieBuilder animationCreator() {
    return Lottie.asset(weather != null
        ? getAnimation(weather?.mainCondition)
        : "assets/lotties/loading.json");
  }
}
