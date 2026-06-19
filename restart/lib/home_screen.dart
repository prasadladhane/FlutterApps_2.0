import "package:flutter/material.dart";
class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State createState()=>_HomeScreenState();
}
class _HomeScreenState extends State{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reborn"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
    );
  }
}