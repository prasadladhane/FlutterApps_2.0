import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registerpage/controller/loginpage.dart';
import 'package:registerpage/view/splash.dart';

class AuthGate extends StatelessWidget{
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context,snapshot){
        //When User is logged in
        if(snapshot.hasData){
          return const StartScreen();
        }

        //when user is not logged in
        else{
          return const Login();
        }
       }
      ),
    );
  }
}