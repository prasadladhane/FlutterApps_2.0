import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/controller/register_customer.dart';
import 'package:registerpage/controller/register_serviceprovider.dart';

class RegisterApp extends StatefulWidget {
  const RegisterApp({super.key});

  @override
  State createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
  // Toggle between customer and service provider registration
  bool showCustomerForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: GoogleFonts.quicksand(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
        backgroundColor: const Color.fromRGBO(27, 48, 101, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Toggle buttons to select between Customer and Service Provider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showCustomerForm = true;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(233, 237, 248, 1),
                      ),
                      child: const Center(
                        child: Text(
                          "Customer",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(52, 111, 249, 1)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showCustomerForm = false;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(233, 237, 248, 1),
                      ),
                      child: const Center(
                        child: Text(
                          "Service Provider",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(52, 111, 249, 1)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Display the appropriate registration form based on the toggle
              if (showCustomerForm) ...[
                Text(
                  "Customer Registration",
                  style: GoogleFonts.quicksand(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const RegisterCustomerForm(),
              ] else ...[
                Text(
                  "Service Provider Registration",
                  style: GoogleFonts.quicksand(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const RegisterServiceProviderForm(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
