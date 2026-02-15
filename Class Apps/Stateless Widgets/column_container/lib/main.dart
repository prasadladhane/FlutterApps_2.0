import "package:flutter/material.dart";

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override

  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: const Text("Column Container App"),
          centerTitle: true,
          backgroundColor: Colors.lime,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 350,
                  height: 50,
                  color: Colors.black,
                ),
                Container(
                  width: 350,
                  height: 50,
                  color: Colors.red,
                ),
                Container(
                  width: 350,
                  height: 50,
                  color:const Color(0xFFFFD700),
                ),
              ],
            ),
          ),
      ),
    );
  }
}