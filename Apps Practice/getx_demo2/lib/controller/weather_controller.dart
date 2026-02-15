import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_demo2/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var weatherData=WeatherModel(
    date: '', 
    weatherConditions: '', 
    currentTemp: '', 
    maxTemp: '', 
    minTemp: ''
  ).obs;

  var isLoading=true.obs;
  Future <void> fetchWeather(String cityName)async{
    try{
      isLoading.value=true;
      var url="https://wttr.in/$cityName?format=j1";
      var response=await http.get(Uri.parse(url));

      if(response.statusCode==200){
        var jsonData=jsonDecode(response.body);
        var weather=WeatherModel.fromJson(jsonData);

        weatherData.value=weather;
      }else{
        Get.snackbar('Error','failed to load weather:${response.statusCode}');
      }
    }catch(e){
      Get.snackbar('Error', 'Something Went Wrong');
    }finally{
      isLoading.value=false;
    }
  }
}