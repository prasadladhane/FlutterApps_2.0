import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BuyNow extends StatefulWidget {
  const BuyNow({super.key});

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  // Function to launch the URL directly in the browser
  Future<void> _launchURL() async {
  const url =
      'https://www.amazon.in/Car-Accessories/b?ie=UTF8&node=5257474031';
  
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    // Show a SnackBar or log the error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not launch URL')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 500,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 300,
                        child: Image.asset("assets/images/buy.jpeg",
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 15, left: 10),
                      child: Text(
                        "Tap on 'Buy Now' and get the best accessories for your car with ease. Shop directly from Amazon and enhance your car's style and comfort today!",
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ]),
                ),
                GestureDetector(
                  onTap: _launchURL, // Directly launches the URL
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 51, 102, 1.0),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromRGBO(245, 245, 245, 1.0))),
                    child: Center(
                      child: Text(
                        "Buy Now",
                        style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

