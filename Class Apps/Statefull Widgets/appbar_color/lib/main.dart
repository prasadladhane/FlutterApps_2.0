import "package:flutter/material.dart";
void main(){
  runApp(const AppBarColor());
}
class AppBarColor extends StatefulWidget{
  const AppBarColor({super.key});

  @override
  State createState()=>_AppBarColor();
}
class _AppBarColor extends State{
  bool colorChange=true;
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: const Text("AppBar Color change App"),
          centerTitle: true,
          backgroundColor: (colorChange)?Colors.amber:Colors.blue,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Change Color"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            if(colorChange){
              colorChange=false;
            }else{
              colorChange=true;
            }
            setState(() {});
          } ,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}