import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_application/models/Weather_model.dart';

class WeatherService {
  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  final String apiKey;

  WeatherService({required this.apiKey});

  // 🌦️ Get weather by city
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  // 📍 Get current city from GPS
  Future<String> getCurrentCity() async {
    // 1️⃣ Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    // 2️⃣ Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }

    // 3️⃣ Get position
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    // 4️⃣ Reverse geocode
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return "Unknown";
    }

    return placemarks.first.locality ?? "Unknown";
  }
}
