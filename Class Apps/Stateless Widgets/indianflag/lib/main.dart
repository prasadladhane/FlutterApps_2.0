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
        appBar: AppBar(
          title: const Text("Indian Flag"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 400,
                  color: Colors.black,
                ),
              ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 250,
                height: 180,
              ),
              Container(
                width: 250,
                height: 35,
                color: Colors.orange,
              ),
              Container(
                width: 250,
                height: 35,
                color: Colors.white,
                child: Image.network("https://photomedia.in/wp-content/uploads/2023/07/ashok-chakra-1024x1024.png"),
              ),
              Container(
                width: 250,
                height: 35,
                color: Colors.green,
              ),
              
                ],    //alignment: Alignment.centerLeft,
              ),
            ],
          ),
        ),
      )
    );
  }
}