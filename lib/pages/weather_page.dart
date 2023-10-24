import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meteo_app/services/weather_services.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService('ee48824d5e9ea5d1644f57a0524094ab');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default :
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 30.0,
            ),

            SizedBox(height: 10),

            // city name
            Text(_weather?.cityName ?? "loading city..",
              style: const TextStyle(
                fontFamily: 'Quicksand', // Utilisez le nom de la police défini dans le pubspec.yaml
                fontSize: 32, // Taille du texte
                color: Colors.white, // Couleur du texte
                fontWeight: FontWeight.bold,
              ),
            ),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text('${_weather?.temperature.round()}°',
              style: const TextStyle(
                fontFamily: 'Quicksand', // Utilisez le nom de la police défini dans le pubspec.yaml
                fontSize: 48, // Taille du texte
                color: Colors.white, // Couleur du texte
                fontWeight: FontWeight.bold,
              ),
            ),

            // weather condition
            Text(_weather?.mainCondition ?? "",
              style: const TextStyle(
                fontFamily: 'Quicksand', // Utilisez le nom de la police défini dans le pubspec.yaml
                fontSize: 20, // Taille du texte
                color: Colors.white, // Couleur du texte
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
      )
    ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.white10,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          print(index);
        }, items: [
          Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
      ],
      ),
    );
  }
}
