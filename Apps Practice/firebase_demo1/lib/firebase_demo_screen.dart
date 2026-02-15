import "dart:developer";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class FirebaseDemoScreen extends StatefulWidget{
  const FirebaseDemoScreen({super.key});

  @override
  State createState()=>_FirebaseDemoScreenState();
}
class _FirebaseDemoScreenState extends State{

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();

  String? email;
  List<Map<String, dynamic>> _userList = [];

  Future getDataFromFirebase()async{
    try{
      QuerySnapshot snapshot =await FirebaseFirestore.instance.collection('users').get();
      final List<Map<String, dynamic>> loadedUsers = [];
      for(var doc in snapshot.docs){
        var data=doc.data()as Map;
        log(data["name"]);
        log(data["email"]);
        loadedUsers.add({
        'name': data['name'],
        'email': data['email'],
      });
      }
      setState(() {
        _userList=loadedUsers;
      });
    }catch(e){
      log("Error:$e");
      }
  }


  /// Below functions adds the data to firebase
  Future addDataToFirebase()async{
    try{
      await FirebaseFirestore.instance.collection('users').add({    ////it creates collection
        'email':_emailController.text,
        'name':_nameController.text
      });
    }catch(e){
      log("User does not added: $e");   ///if data not stored in collection it shows error
    }
  }

  void showStorePopUp(){
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        content: Text("data Added successfully"),
      ),
    );
  }
  void removeInputFromTextField(){
    _nameController.clear();
    _emailController.clear();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: const Text("Firebase Operations",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all()
              ),
              child: TextField(
                controller:_nameController,
                decoration: InputDecoration(
                  labelText: "Enter Name"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all()
                ),
                child: TextField(
                  controller:_emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Email"
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: GestureDetector(
                onTap: () {
                  if(_emailController.text.isNotEmpty && _nameController.text.isNotEmpty){
                    addDataToFirebase();
                    showStorePopUp();
                  }else{
                    log("Enter credintials first");
                  }
                  removeInputFromTextField();
                },
                child: Container(
                  height: 56,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all()
                  ),
                  child: const Text("Submit",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:200),
              child: GestureDetector(
                onTap: () {
                  getDataFromFirebase();
                },
                child: Container(
                  height:56,
                  width:200,
                  alignment: Alignment.center,
                  color: Colors.purple,
                  child: Text("Get Data"),
                )
              ),
            ),
            _userList.isEmpty
            ? Text("No users found yet.")
            : Column(
              children: _userList.map((user) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${user['name']}"),
                    Text("Email: ${user['email']}"),
                    Divider(),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}