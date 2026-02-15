import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/controller/loginpage.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State {
  //UserSign out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//A map to store the fetched user data from Firestore.
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final User? currentUser =
          _firebaseAuth.currentUser; //Get the user which is currently login
      if (currentUser != null) {
        final DocumentSnapshot userDoc =
            //fetch document from firebase
            await _firestore.collection('users').doc(currentUser.uid).get();

        if (userDoc.exists) {
          setState(() {
            //store data from firebase into map
            userData = userDoc.data() as Map<String, dynamic>;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(27, 48, 101, 1),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 40),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.blue),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                signOut;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                    (Route<dynamic> route) => false);
                              });
                            },
                            child: const Icon(Icons.logout_rounded,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 3,
                        color: const Color.fromRGBO(27, 48, 101, 1),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(98, 115, 159, 1),
                          blurRadius: 10,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          "https://cdn-icons-png.freepik.com/256/16383/16383457.png?semt=ais_hybrid",
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    userData?['firstName'] != null
                        ? "${userData!['firstName']} ${userData!['lastName']}"
                        : "User Name",
                    style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50, bottom: 10, left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          "Personal Information",
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      buildInfoTile(
                        icon: Icons.mail_outlined,
                        label: "Email",
                        value: userData?['email'] ?? "N/A",
                      ),
                      buildInfoTile(
                        icon: Icons.phone_android_outlined,
                        label: "Phone",
                        value: userData?['mobile'] ?? "N/A",
                      ),
                      buildInfoTile(
                        icon: Icons.perm_identity_outlined,
                        label: "Service type",
                        value: userData?['serviceType'] ?? "N/A",
                      ),
                      buildInfoTile(
                        icon: Icons.location_pin,
                        label: "Location",
                        value: userData?['location'] ?? "N/A",
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

//A reusable widget to build information tiles.
  Widget buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 3),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 36, 35, 35),
          borderRadius: label == "Location"
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
              : label == "Email"
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(48, 88, 180, 1),
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(48, 88, 180, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
