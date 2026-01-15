import 'package:flutter/material.dart';
import 'package:weather_application/Service/weather_service.dart';
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
  _fetchWeather() async {
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

  // initial state
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "Loading..."),

            //temp
            Text("${_weather?.temperature.round()} °C"),
          ],
        ),
      ),
    );
  }
}
