import 'package:flutter/material.dart';
import 'package:wheather_app/feature/home/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Raleway"
      ),
      home: const HomeView(),
    );
  }
}
