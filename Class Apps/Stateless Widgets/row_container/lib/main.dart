import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

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
          title: const Text("Container Row App"),
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: Center(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.green,
            ),
            Container(
              height: 50,
              width: 50,
              color: Colors.brown,
            ),
            Container(
              height: 50,
              width: 50,
              color: Colors.purple,
            ),
          ],
          )
          ),
        ),
    );
  }
}
