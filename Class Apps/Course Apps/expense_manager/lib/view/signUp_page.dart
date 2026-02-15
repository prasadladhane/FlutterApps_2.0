import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SignUpPage  extends StatefulWidget{
  const SignUpPage({super.key});
  @override
  State createState()=> _SignUp_pageState();
}
// ignore: camel_case_types
class _SignUp_pageState extends State{

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _userNameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _confirmPasswordController=TextEditingController();

  void _clearData(){
    _nameController.clear();
    _userNameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.keyboard_arrow_left,
            size: 30,
          ),
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(42),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child:Image.asset("assets/images/flash screen.png") ,
              ),
              Padding(
                padding: const EdgeInsets.only(top:50),
                child: Text(
                  "Create your Account",
                  style:GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height:20),
              Container(
                height: 49,
                width:MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  boxShadow: []
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border:OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height:20),
              Container(
                height:49,
                width:MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  boxShadow: []
                ),
                child: TextField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    border:OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height:20),
              Container(
                height: 49,
                width:MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  boxShadow: []
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border:OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height:20),
              Container(
                height:49,
                width:MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  boxShadow: []
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border:OutlineInputBorder(),
                  ),
                ),
              ), 
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  _clearData();
                },
                child: Container(
                  height: 49,
                  width:MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color:Color.fromRGBO(14, 161, 125, 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child:Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  )
                ),
              ),   
            ],
          ),
        ),
      )
    );
  }
}