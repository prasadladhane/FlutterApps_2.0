import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/view/userSide_ui/customer_home_page.dart';
import 'package:registerpage/controller/loginpage.dart';
import 'dart:async';
import 'package:registerpage/model/funct_model/session_data.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  void navigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      //bool status = false;

      SessionData.getSessionData();
      log("IS LOGIN :${SessionData.isLogin}");

      if (SessionData.isLogin!) {
        log("Navigate to home");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const CustomerHomePage(email: "email");
            },
          ),
        );
      } else {
        log("Navigate to login");
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const Login();
        }));
      }
    });
  }

  @override
  State createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Set up a fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start animation
    _controller.forward();

    // Trigger navigation with delay
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        _createCustomRoute(const Login()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Custom Page Route with Animation
  Route _createCustomRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Start from bottom
        const end = Offset.zero; // End at normal position
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://i.pinimg.com/originals/ba/e8/c1/bae8c190b56e3872101e1511ac67729f.jpg",
              fit: BoxFit.cover,
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 50),
                  child: SizedBox(
                    height: 100,
                    width: 210,
                    child: Text(
                      "Anywhere, Travel Guard is Here Reliable Travel services, wherever you need us...!",
                      style: GoogleFonts.podkova(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        _createCustomRoute(const Login()),
                      );
                    },
                
                    child: Center(
                      child: Text(
                        "Travel Guard",
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
