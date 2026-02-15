import "package:flutter/material.dart";
import "package:getx_demo1/view/screen1.dart";
import "package:get/get.dart";
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:Screen1(),
    );
  }
}