import "dart:convert";
import "dart:developer";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class ApiDemo2Screen extends StatefulWidget{
  const ApiDemo2Screen({super.key});

  @override
  State createState()=>_ApiDemo2Screen();
}
class _ApiDemo2Screen extends State{
  String? imageUrl;

  Future <String> fetchImage()async{
    final response= await http.get(Uri.parse("https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=1"));

    if(response.statusCode==200){
      final data=jsonDecode(response.body) as List;
      final item = data[0];
      setState(() {
        imageUrl = item['hdurl'] ?? item['url'];
      });
    }else{
      throw Exception('failed to laod image');
    }
    throw Exception("No valid image found");
  }

  void loadImage()async{
    setState(() {});
    try{
      final url=await fetchImage();
      setState(() {
        imageUrl=url;
      });
    }catch(e){
      log("failed loading:$e");
    }
  }
  @override
  void initState(){
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Space Photos",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 500,
              width: 500,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Image.network("$imageUrl",fit: BoxFit.cover,height:double.infinity,width: double.infinity,),
            ),
            Padding(
              padding: const EdgeInsets.only(top:18),
              child: GestureDetector(
                onTap: () {
                  loadImage();
                },
                child: Container(
                  height:56,
                  width:200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Text("See Next Photo",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}