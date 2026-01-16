class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String main;
  final String icon;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.main,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherData = json['weather'][0];

    return Weather(
      cityName: json['name'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      description: weatherData['description'] as String,
      main: weatherData['main'] as String,
      icon: weatherData['icon'] as String,
    );
  }
}
