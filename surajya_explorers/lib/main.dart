import "package:flutter/material.dart";
import "package:surajya_explorers/blog_screen.dart";

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlogScreen(),
    );
  }
}