import "package:flutter/material.dart";
import "package:provider_demo1_trip_packer/providers/packing_provider.dart";
import "package:provider_demo1_trip_packer/providers/theme_provider.dart";
import "package:provider_demo1_trip_packer/screens/packing_screen.dart";
import "package:provider/provider.dart";

void main(){
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create:(_)=>PackingProvider()),
        ChangeNotifierProvider(create:(_)=>ThemeProvider()),
      ],
      child:const MyApp()
    ),
  );
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    final themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "Trip Packer",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark
      ),
      themeMode: themeProvider.currentTheme,
      home:const PackingScreen()
    );
  }
}
