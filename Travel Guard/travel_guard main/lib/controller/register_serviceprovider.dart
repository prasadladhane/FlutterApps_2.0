import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/model/ui_model/snackbar.dart';
import 'package:registerpage/controller/loginpage.dart';

class RegisterServiceProviderForm extends StatefulWidget {
  const RegisterServiceProviderForm({super.key});

  @override
  State createState() => _RegisterServiceProviderFormState();
}

class _RegisterServiceProviderFormState extends State<RegisterServiceProviderForm> {
  String? selectedOption; // Holds the selected value
  List<String> options = ['Ambulance', 'Mechanics', 'Towing Van', 'Traffic Police']; // Dropdown options
  

  // Method to show a popup menu below the suffix arrow
  void _showPopupMenu(BuildContext context) async {
    final RenderBox textFieldRenderBox = context.findRenderObject() as RenderBox;
    final Offset offset = textFieldRenderBox.localToGlobal(Offset.zero);

    // Calculate the X position to align the menu to the right side of the TextField's arrow
    final double arrowXPosition = offset.dx + textFieldRenderBox.size.width - 40; // Adjust for right alignment
    final double arrowYPosition = offset.dy + textFieldRenderBox.size.height; // Y position below the TextField

    final String? selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        arrowXPosition, // X position for the right-aligned menu
        arrowYPosition, // Y position below the TextField
        arrowXPosition + textFieldRenderBox.size.width, // Ensure proper alignment on the right
        0,
      ),
      items: options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );

    if (selected != null) {
      setState(() {
        selectedOption = selected;
        _serviceTypeController.text = selected; // Set the selected value to the TextField
      });
    }
  }
  
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _serviceTypeController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerServiceProvider() async {
    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _serviceTypeController.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        log("Service Provider Registered: ${userCredential.user!.email}");

        // Save additional details for the service provider in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'mobile': _mobileController.text,
          'email': _emailController.text,
          'location': _locationController.text,
          'serviceType': _serviceTypeController.text,
          'userType': 'serviceProvider', // Mark user as a service provider
        });

        fetchCustomersFromFirestore();
        CustomSnackbar.showCustomSnackbar(
          message: "Service Provider Registered Successfully",
          context: context,
        );

        // Navigate to Login screen after successful registration
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } on FirebaseAuthException catch (e) {
        log("Error: ${e.code}");
        CustomSnackbar.showCustomSnackbar(
          message: e.message ?? "An error occurred",
          context: context,
        );
      }
    } else {
      CustomSnackbar.showCustomSnackbar(
        message: "Please fill all fields",
        context: context,
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchCustomersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    return querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data(),
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        TextField(
          controller: _firstNameController,
          decoration: InputDecoration(
            labelText: "First Name",
            hintStyle: GoogleFonts.quicksand(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 14, 24), width: 1),
            ),
          ),
        ),

        const SizedBox(height: 15),
        
        TextField(
          controller: _lastNameController,
          decoration: InputDecoration(
            labelText: "Last Name",
            hintStyle: GoogleFonts.quicksand(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 14, 24), width: 1),
            ),
          ),
        ),

        const SizedBox(height: 15),
        
        TextField(
          controller: _mobileController,
          decoration: InputDecoration(
            labelText: "Mobile Number",
            hintStyle: GoogleFonts.quicksand(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 14, 24), width: 1),
            ),
          ),
        ),

        const SizedBox(height: 15),
        
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: "Email ID",
            hintStyle: GoogleFonts.quicksand(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 14, 24), width: 1),
            ),
          ),
        ),

        const SizedBox(height: 15),

        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            hintStyle: GoogleFonts.quicksand(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 14, 24), width: 1),
            ),
          ),
        ),

        const SizedBox(height: 15),

        TextField(
          controller: _locationController,
          decoration: InputDecoration(
            labelText: "Location",
            hintStyle: GoogleFonts.quicksand(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 14, 24), width: 1),
            ),
          ),
        ),

        const SizedBox(height: 15),

        TextField(
          controller: _serviceTypeController,
          readOnly: true,
          decoration: InputDecoration(
            suffix: const Icon(Icons.arrow_drop_down),
            labelText: "Select service",
            hintStyle: GoogleFonts.quicksand(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 14, 24), width: 1),
            ),
          ),
          onTap:(){
            _showPopupMenu(context); // Show popup menu on tap
          }
        ),

        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: registerServiceProvider,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width, 50),
            backgroundColor: const Color.fromRGBO(52, 111, 249, 1),
          ),
          child: Text("Create Account",
              style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w600)),
        ),

        const SizedBox(height: 20),
        
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
          child: Text("Already have an account? Login",
              style: GoogleFonts.quicksand(
                  color: Colors.black, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
