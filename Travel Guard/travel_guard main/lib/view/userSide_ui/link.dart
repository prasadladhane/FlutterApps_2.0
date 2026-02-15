import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BuyHere extends StatefulWidget {
  const BuyHere({super.key});

  @override
  State<BuyHere> createState() => _BuyHereState();
}

class _BuyHereState extends State<BuyHere> {
  // Function to launch the URL
  Future<void> _launchURL() async {
    const url =
        'https://www.amazon.in/Car-Accessories/b?ie=UTF8&node=5257474031'; // Amazon link
    final Uri uri = Uri.parse(url);

    // Check if the URL can be launched
    if (await canLaunchUrlString(uri.toString())) {
      await launchUrlString(uri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Image.asset("assets/images/open.jpeg",
                  fit: BoxFit.cover, height: 400, width: 500),
            ),
            GestureDetector(
              onTap: _launchURL, // Trigger the URL launch when tapped
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "https://www.amazon.in/Car-Accessories/b?ie=UTF8&node=5257474031",
                  style: GoogleFonts.quicksand(
                      color: Colors.blue, // Make the text look like a link
                      decoration: TextDecoration.underline,
                      // Underline the text to indicate it's clickable
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
