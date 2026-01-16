import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/Weather_model.dart';

class WeatherView extends StatelessWidget {
  final Weather? weather;
  final String Function(String? main, String? icon) getWeatherAnimation;

  const WeatherView({
    super.key,
    required this.weather,
    required this.getWeatherAnimation,
  });

  bool _isNight(String? icon) {
    return icon != null && icon.endsWith('n');
  }

  @override
  Widget build(BuildContext context) {
    final isNight = _isNight(weather?.icon);

    return AnimatedTheme(
      duration: const Duration(milliseconds: 500),
      data: isNight ? _nightTheme : _dayTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: weather == null
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weather!.cityName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),

                        const SizedBox(height: 20),

                        Lottie.asset(
                          getWeatherAnimation(weather!.main, weather!.icon),
                          width: 200,
                          height: 200,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "${weather!.temperature.round()} °C",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          weather!.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

/* ---------------- THEMES ---------------- */

final ThemeData _dayTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.blue.shade100,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black87),
  ),
);

final ThemeData _nightTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0F172A),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white70),
  ),
);
