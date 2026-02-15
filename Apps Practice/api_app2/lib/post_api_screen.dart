import "dart:developer";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class PostApiDemo extends StatefulWidget{
  const PostApiDemo({super.key});

  @override
  State createState()=>_PostApiDemoState();
}
class _PostApiDemoState extends State{

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void login(String email,String password)async{
    try{
      http.Response response= await http.post(
        Uri.parse("https://dummyjson.com/auth/login"),
        body:{
          'username':email,
          'password':password
        }
      );
      if(response.statusCode==200){
        log("account created successfully");
      }else{
        log("signup failed");
      }
    }
    catch(e){
      log("mo");
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: const Text("Post API Call Demo"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
            SizedBox(height:10),
            GestureDetector(
              onTap: () {
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height:50,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child:Text("SignUp")
              ),
            )
          ],
        ),
      ),
    );
  }
}