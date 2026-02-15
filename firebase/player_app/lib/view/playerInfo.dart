import "package:flutter/material.dart";
class PlayerInfoScreen extends StatefulWidget{
  const PlayerInfoScreen({super.key});
  @override
  State createState()=>_PlayerInfoScreenState();
}
class _PlayerInfoScreenState extends State{




  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        title:const Text("Players App"),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset("assets/images/profile icon.jpg"),
            const SizedBox(height:20),
            const TextField(
              decoration: InputDecoration(
                label:Text("Player Name"),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.white)
                )
              ),
            ),
            const SizedBox(height:20),
            const TextField(
              decoration: InputDecoration(
                label:Text("Player Jersey No"),
                border:OutlineInputBorder(
                  borderSide:BorderSide(color:Colors.white)
                )
              ),
            ),
            
          ],
        ),
      )
    );
  }
}