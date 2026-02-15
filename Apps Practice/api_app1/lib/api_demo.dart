import "package:flutter/material.dart";
import "dart:convert";
import "dart:developer";
import "package:http/http.dart" as http;

class ApiDemo1 extends StatefulWidget{
  const ApiDemo1({super.key});

  @override
  State createState()=>_ApiDemo1State();
}
class _ApiDemo1State extends State{

  String ?imageURL;
  bool isLoading=false;

  // void postData()async{
  //   Uri url=Uri.parse("https://dummy.restapiexample.com/api/v1/create");

  //   Map deviceData={
  //     'name':"new id",
  //     'data':'4040'};
  //     http.Response response=await http.post(url,body: json.encode(deviceData));
  // }
  Future fetchImage()async{
    final response=await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if (response.statusCode==200){
      final data=jsonDecode(response.body);
      return data['message'];
    }else{
      throw Exception('Image loading failed');
    }
  }

  void loadImage()async{
    try{
      final url=await fetchImage();
      setState(() {
        imageURL=url;
        isLoading=false;
      });
    }catch(e){
      log('Error:$e');
      setState(()=>isLoading=false);
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
        title: const Text("API Demo 1",style:TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child:isLoading
              ? CircularProgressIndicator()
              : imageURL!=null
              ?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(imageURL!),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: loadImage,
                        child: Text('Load Another Image'),
                      ),
                    ],
              )
              :Text("No Image Loaded"),
            )
          ],
        ),
      ),
    );
  }
}