import "package:flutter/material.dart";

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: const Text("Center Container App"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body:Center(
           child: Container(
              width:250,
              height:250,
              color: Colors.amber,
            )
        ),
      ),
    );
  }
}