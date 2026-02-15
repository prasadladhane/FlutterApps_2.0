import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo2/controller/weather_controller.dart';

class GetXDemo2 extends StatelessWidget {
  GetXDemo2({super.key});
  final WeatherController weatherController = Get.put(WeatherController());
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // City Input Field
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (cityController.text.isNotEmpty) {
                      weatherController.fetchWeather(cityController.text.trim());
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Loading Indicator
            Obx(() {
              if (weatherController.isLoading.value) {
                return CircularProgressIndicator();
              }

              // Display Weather Data
              return Obx(() {
                var data = weatherController.weatherData.value;

                if (data.date == '') {
                  return Text('No data found. Please search a city.');
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${data.date}', style: TextStyle(fontSize: 18)),
                    Text('Weather: ${data.weatherConditions}', style: TextStyle(fontSize: 18)),
                    Text('Current Temp: ${data.currentTemp}°C', style: TextStyle(fontSize: 18)),
                    Text('Max Temp: ${data.maxTemp}°C', style: TextStyle(fontSize: 18)),
                    Text('Min Temp: ${data.minTemp}°C', style: TextStyle(fontSize: 18)),
                  ],
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}
