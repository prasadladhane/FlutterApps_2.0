class WeatherModel {
  String? date;
  String? weatherConditions;
  String? currentTemp;
  String? maxTemp;
  String? minTemp;

  WeatherModel({
    required this.date,
    required this.weatherConditions,
    required this.currentTemp,
    required this.maxTemp,
    required this.minTemp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['weather'][0]['date'] ?? '',
      weatherConditions: json['current_condition'][0]['weatherDesc'][0]['value'] ?? '',  
      currentTemp: json['current_condition'][0]['temp_C'] ?? '',
      maxTemp: json['weather'][0]['maxtempC'] ?? '',    
      minTemp: json['weather'][0]['mintempC'] ?? '',    
    );
  }
}
