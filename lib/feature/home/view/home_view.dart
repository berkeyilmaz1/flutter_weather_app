import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather_app/feature/home/shared/styles/text_styles.dart';
import 'package:wheather_app/feature/home/view_model/home_viewmodel.dart';
import 'package:wheather_app/product/utility/components/icon_card.dart';
import 'package:wheather_app/product/utility/constants/project_constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  final String cityError = "City Name Not Found";
  final String conditionError = "Condition Not Found";
  final String descriptionError = "Description Not Found";
  final String subtitleTemp = "Feels Like";
  final String subtitleHumidity = "Humidity";
  final String subtitleWind = "Wind Speed";
  final String fiveDaysForecastTitle = "5 Days Forecast";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ProjectColors.projectBackground,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ///Top parf of the app- Current Weather
              Flexible(flex: 4, child: topPartOfApp()),

              ///Bottom part of the app- Forecast
              Flexible(flex: 1, child: forecast(context)),
            ],
          ),
        ));
  }

  Column topPartOfApp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        cityName(),
        animationCreator(),
        degreeShower(),
        conditions(),
        otherProperties()
      ],
    );
  }

  Text cityName() {
    return Text(
      weather?.cityName ?? cityError,
      style: appTitle,
    );
  }

  Padding otherProperties() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
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
      ),
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

  SizedBox animationCreator() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      child: Lottie.asset(weather != null
          ? getAnimation(weather?.mainCondition)
          : "assets/lotties/loading.json"),
    );
  }

  Column forecast(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text(fiveDaysForecastTitle, style: fiveDaysForecastStyle),
            ],
          ),
        ),
        items == null
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.width / 3.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items!.length,
                  itemBuilder: (context, index) {
                    final item = items![index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 2)
                            ],
                            border: Border.fromBorderSide(
                                BorderSide(color: ProjectColors.bordorColor)),
                            color: ProjectColors
                                .forecastCardColor, //card's background
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            timeChanger(item.date),
                            SizedBox(
                                width: 48,
                                height: 48,
                                child: Lottie.asset(item != null
                                    ? getAnimation(item.mainCondition)
                                    : "assets/lotties/loading.json")),
                            Text("${item.temp ?? 'null'}°C",
                                style: forecastTimeDateDegreeStyle),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
