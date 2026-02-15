import "package:flutter/material.dart";

void main(){
  runApp(const PlayersApp());
}
class PlayersApp extends StatefulWidget{
  const PlayersApp({super.key});

  @override
  State createState()=>_PlayersApp();
}
class _PlayersApp extends State{
  int _counter=0;
  List player=[
    "https://www.hindustantimes.com/static-content/1y/cricket-logos/players/virat-kohli.png",
    "https://assets.vogue.in/photos/5f3a37acac1b7909f36d6814/2:3/w_2560%2Cc_limit/Mahendra%2520Singh%2520Dhoni%2520fun%2520facts.jpg",
    "https://static.toiimg.com/thumb/resizemode-4,width-1280,height-720,msid-111741230/111741230.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReTvYN0hhGw326DpFMWXKMQ6LgEU_JFxdIbA&s"
    ];
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: const Text("Cricket Player App"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              Image.network(player[_counter],
              height: 300,
              ),
            ],
          ),
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_counter<player.length-1){
              _counter++;
            }else{
              _counter=0;
            }
            setState(() {});
          },
          tooltip: "Next",
          child: const Icon(
            Icons.forward,
          ),
          ),
      ),
    );
  }
}