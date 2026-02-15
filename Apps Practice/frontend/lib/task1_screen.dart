import "package:flutter/material.dart";

class Task1Screen extends StatefulWidget{
  const Task1Screen({super.key});

  @override
  createState()=> _Task1Screeen();
}
class _Task1Screeen extends State{


  TextEditingController nameController=TextEditingController();
  TextEditingController agencyNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height:600,
                  width: 600,
                  child: Image.asset("assets/front.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:350),
                  child: Column(
                    children: [
                      const Text(
                      "Join AgencyPro Today",
                      style:TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        child: TextField(
                          controller:TextEditingController(),
                          decoration: const InputDecoration(
                            label:Text("Name",style:TextStyle(fontSize: 8)) 
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        controller:TextEditingController(),
                        decoration: const InputDecoration(
                          label: Text("Email",style:TextStyle(fontSize: 8))
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        controller:TextEditingController(),
                        decoration: const InputDecoration(
                          label: Text("Password",style:TextStyle(fontSize: 8))
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        controller:TextEditingController(),
                        decoration: const InputDecoration(
                          label: Text("Decription",style:TextStyle(fontSize: 8))
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        controller:TextEditingController(),
                        decoration: const InputDecoration(
                          label: Text("Phone Number",style:TextStyle(fontSize: 8))
                        ),
                      ),
                      const SizedBox(height:10),
                      const Text("Upload License",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      const SizedBox(height:10),
                      const Row(
                        children: [
                          Text(
                            "Choose file",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14
                            ),
                          ),
                          SizedBox(width:10),
                          Text("No file choosen"),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        height:30,
                        width:50,
                        alignment: Alignment.center,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}