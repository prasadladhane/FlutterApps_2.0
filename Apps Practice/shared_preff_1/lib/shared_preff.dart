import "dart:developer";

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class SharedPreffDemo extends StatefulWidget {
  const SharedPreffDemo({super.key});

  @override
  State createState()=>_SharedPreffDemoState();
}
class _SharedPreffDemoState extends State{

  String? userName;
  String? password;

  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();


  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }


  void _loadSavedData()async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    String? savedUsername=prefs.getString('username');
    String? savedPassword=prefs.getString('password');
  
    if(savedUsername !=null &&savedPassword !=null){  
      setState((){
        userName=savedUsername;
        password=savedPassword;
      });
    }
  }

  void _sharedLogic(String userNameInput,String passwordInput)async{
    if(userNameInput.isNotEmpty  && passwordInput.isNotEmpty ){
        final SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setString('username',userNameInput);
        prefs.setString('password',passwordInput);
        setState(() {
          userName=userNameInput;
          password=passwordInput;
          log("$userName $password");
        });
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful"))
);
        clearField();
    }else{
      log("Please Enter All Credintials");
    }
  }

  void clearField(){
    _usernameController.clear();
    _passwordController.clear();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preference Demo"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child:TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Enter User Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide()
                  )
                ),
              )
            ),
            const SizedBox(height:20),
            SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child:TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide()
                  )
                ),
              )
            ),
            const SizedBox(height:30),
            GestureDetector(
              onTap: (){
                _sharedLogic(_usernameController.text.trim(),_passwordController.text.trim());
              },
              child: Container(
                height:56,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                child:Text("Login")
              ),
            ),
            if ((userName ?? '').isNotEmpty && (password ?? '').isNotEmpty) 
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Saved Usename: $userName"),
                  const SizedBox(height:10),
                  Text("Saved Password: $password")
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}