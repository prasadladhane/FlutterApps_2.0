import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/view/userSide_ui/customer_home_page.dart';
import 'package:registerpage/controller/both_registerpage.dart';
import 'package:registerpage/view/serviceProviderSide_ui/home_serviceprovider.dart';
import 'package:registerpage/model/ui_model/snackbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  PageController pageController = PageController();
  late Timer timer;

  List imageList = [
    {
      'image':
          "https://t3.ftcdn.net/jpg/09/97/80/68/360_F_997806856_326JLxkamGDcKVDLziRnmji1Y7tHHemb.jpg",
      'text':
          '"Keep your wheels rolling with our 24/7 online mechanic support."'
    },
    {
      'image':
          "https://img.freepik.com/premium-vector/towing-service-truck-isolated-black-background-poster-t-shirt-print-business-element_500504-598.jpg",
      'text': 'Your roadside rescue team—24/7 towing services for all vehicles'
    },
    {
      'image':
          "https://thumbs.dreamstime.com/b/ambulance-night-lone-its-flashing-lights-piercing-dark-stands-ready-to-transport-patient-need-quiet-promise-335265507.jpg",
      'text': 'Expert care on wheels—reaching you in the moments that matter'
    },
    {
      'image':
          "https://thumbs.dreamstime.com/b/police-officer-near-car-lights-city-street-selective-focus-bokeh-police-officer-near-car-lights-city-306746265.jpg",
      'text':
          'Stay informed, stay safe—connect with your traffic police anytime'
    },
    {
      'image':
          "https://i.pinimg.com/736x/ed/58/5d/ed585d8804401e69828874f1681706cf.jpg",
      'text':
          'Your trusted partner for travel emergencies—quick, reliable, and always prepared'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Timer for auto-scrolling
    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      int nextPage = (pageController.page?.toInt() ?? 0) + 1;
      if (nextPage >= imageList.length) {
        nextPage = 0; // Loop back to the first page
      }
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to prevent memory leaks
    pageController.dispose();
    super.dispose();
  }

//Login User
  Future<void> _login() async {
    if (_emailTextEditingController.text.trim().isNotEmpty &&
        _passwordtextEditingController.text.trim().isNotEmpty) {
      try {
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailTextEditingController.text,
          password: _passwordtextEditingController.text,
        );
        log("TG:UserCredentials:${userCredential.user!.email}");

        // Fetch user data from Firestore to get userType
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        String userType =
            userDoc['userType']; // "customer" or "serviceProvider"
        if (userType == 'serviceProvider') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ServiceProviderHome()),
          );
        } else if (userType == 'customer') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CustomerHomePage(
                email: '',
              ),
            ),
          );
        } else {
          CustomSnackbar.showCustomSnackbar(
            message: "Invalid user type",
            context: context,
          );
        }
      } on FirebaseAuthException catch (error) {
        log("TG :ERROR:${error.code}");
        CustomSnackbar.showCustomSnackbar(
          message: error.code,
          context: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: imageList.length,
                itemBuilder: (BuildContext context, index) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 400,
                                width: MediaQuery.of(context).size.width - 40,
                                child: Image.network(
                                    "${imageList[index % imageList.length]['image']}"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 90,
                              child: Text(
                                "${imageList[index % imageList.length]['text']}",
                                style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: imageList.length,
              effect: const ExpandingDotsEffect(),
              onDotClicked: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    controller: _emailTextEditingController,
                    decoration: const InputDecoration(
                      fillColor: Colors.grey,
                      labelText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    controller: _passwordtextEditingController,
                    decoration: const InputDecoration(
                      fillColor: Colors.grey,
                      labelText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: _login,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(52, 111, 249, 1),
                        // gradient: LinearGradient(colors: [
                        //   Color.fromARGB(255, 14, 96, 162),
                        //   Color.fromARGB(255, 14, 96, 162)
                        // ]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  "Forgot Password?",
                  style: GoogleFonts.quicksand(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const RegisterApp();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "New Account? Register",
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
