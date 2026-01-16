import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_application/Service/weather_service.dart';
import 'package:weather_application/Widgets/Weather_view.dart';
import 'package:weather_application/models/Weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherServive = WeatherService(
    apiKey: 'd30b3a9814351f49523e05b696c90f31',
  );
  Weather? _weather;

  //fetch weather
  Future<void> _fetchWeather() async {
    //get the current city
    String cityName = await _weatherServive.getCurrentCity();

    // get weather
    try {
      final weather = await _weatherServive.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
      //catch error
    } catch (error) {
      print(error);
    }
  }

  // weather animations
  String getWeatherAnimation(String? description, String? icon) {
    final isNight = icon != null && icon.endsWith('n');

    if (description == null) {
      return isNight ? "assets/night.json" : "assets/sunny.json";
    }

    switch (description.toLowerCase()) {
      case 'clear sky':
        return isNight ? "assets/night.json" : "assets/sunny.json";

      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return "assets/cloudy.json";

      case 'rain':
      case 'shower rain':
        return "assets/rainy.json";

      case 'thunderstorm':
        return "assets/thunder.json";

      case 'snow':
        return "assets/snow.json";

      case 'mist':
      case 'dust':
      case 'haze':
        return "assets/cloud.json";

      default:
        return isNight ? "assets/night.json" : "assets/sunny.json";
    }
  }

  // initial state
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return WeatherView(
      weather: _weather,
      getWeatherAnimation: getWeatherAnimation,
    );
  }
}
