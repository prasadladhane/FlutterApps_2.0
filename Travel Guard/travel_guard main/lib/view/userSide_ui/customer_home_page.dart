// home screen                                                                                                                             // import "package:animation1/profile_page.dart";
import "dart:async";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:registerpage/view/userSide_ui/availabiltytoing.dart";
import "package:registerpage/view/userSide_ui/availabitytraffic.dart";
import "package:registerpage/model/avilabilityambulance.dart";
import "package:registerpage/view/userSide_ui/buy_now.dart";
import "package:registerpage/model/ui_model/snackbar.dart";
import "package:registerpage/view/userSide_ui/user_profile.dart";
import "availability.dart";
import 'package:google_fonts/google_fonts.dart';

class CustomerHomePage extends StatefulWidget {
  //  final String userLocation;
  const CustomerHomePage({super.key, required String email});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  int _selectedIndex = 0;

  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    // super.initState();
    _startAutoScroll();
    Firebase.initializeApp();
    fetchUserData();
  }

  Future<void> _checkAvailability() async {
    final mechanicRef = FirebaseFirestore.instance.collection('mechanics');

    final mechanicData = {
      'Problem': _problemController.text,
      'Location': _locationController.text,
      'Vehicle Type': _vehicleTypeController.text,
      'requestTime': FieldValue.serverTimestamp(),
    };
    await mechanicRef.add(mechanicData); // Add data to Firestore
    //     print('Data successfully added to Firestore');

    if (_problemController.text.trim().isNotEmpty &&
        _locationController.text.trim().isNotEmpty &&
        _vehicleTypeController.text.trim().isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Availability(
          userLocation: _locationController.text.trim(),
          userproblem: _problemController.text.trim(),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  // Future<void> _checkAvailabilityt() async {
  //   // Firebase Firestore collection reference
  //   final toingRef = FirebaseFirestore.instance.collection('toingVan');

  //   // Data to be added to Firestore
  //   final toingData = {
  //     'Problem': _problemController.text,
  //     'Location': _locationController.text,
  //     'Vehicle Type': _vehicleTypeController.text,
  //   };

  //   try {
  //     await toingRef.add(toingData); // Add data to Firestore
  //     print('Data successfully added to Firestore');

  //     // Clear the text fields after submission
  //     _problemController.clear();
  //     _locationController.clear();
  //     _vehicleTypeController.clear();

  //     // Optionally, show a Snackbar or dialog
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Toing van data submitted successfully!'),
  //     ));
  //   } catch (e) {
  //     print('Error adding data: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Failed to submit data!'),
  //     ));
  //   }
  // }


  Future<void> _checkAvailabilityt() async {
    final mechanicRef = FirebaseFirestore.instance.collection('toingVan');

    final mechanicData = {
      'Problem': _problemController.text,
      'Location': _locationController.text,
      'Vehicle Type': _vehicleTypeController.text,
      'requestTime': FieldValue.serverTimestamp(),

     };
     await mechanicRef.add(mechanicData); // Add data to Firestore
  //     print('Data successfully added to Firestore');




    if (_problemController.text.trim().isNotEmpty &&
        _locationController.text.trim().isNotEmpty &&
        _vehicleTypeController.text.trim().isNotEmpty
        ) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Availabilitytoing (
          userLocation: _locationController.text.trim(),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    } 
  }

//for trafficpolice
  // Future<void> _checkAvailabilitytf() async {
  //   // Firebase Firestore collection reference
  //   final trafficRef = FirebaseFirestore.instance.collection('trafficPolice');

  //   // Data to be added to Firestore
  //   final trafficData = {
  //     'Problem': _problemController.text,
  //     'Location': _locationController.text,
  //   };

  //   try {
  //     await trafficRef.add(trafficData); // Add data to Firestore
  //     print('Data successfully added to Firestore');

  //     // Clear the text fields after submission
  //     _problemController.clear();
  //     _locationController.clear();
  //     _vehicleTypeController.clear();

  //     // Optionally, show a Snackbar or dialog
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Traffic police data submitted successfully!'),
  //     ));
  //   } catch (e) {
  //     print('Error adding data: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Failed to submit data!'),
  //     ));
  //   }
  // }

  ///mainTrafficPolice
  Future<void> _checkAvailabilitytf() async {
    final mechanicRef = FirebaseFirestore.instance.collection('Ambulance');

    final mechanicData = {
       //'Problem': _problemController.text,
      'Location': _locationController.text,
       //'Vehicle Type': _vehicleTypeController.text,
     };
     await mechanicRef.add(mechanicData); // Add data to Firestore
  //     print('Data successfully added to Firestore');

    if (//_problemController.text.trim().isNotEmpty &&
        _locationController.text.trim().isNotEmpty //&&
        //_vehicleTypeController.text.trim().isNotEmpty
        ) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AvailabilityTraffic(
          userLocation: _locationController.text.trim(),
        ),
      )
      
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    } 
  }



//for ambulance
  // Future<void> _checkAvailabilityA() async {
  //   // Firebase Firestore collection reference
  //   final ambulanceRef = FirebaseFirestore.instance.collection('Ambulance');

  //   // Data to be added to Firestore
  //   final ambulanceData = {
  //     'Problem': _problemController.text,
  //     'Location': _locationController.text,
  //   };

  //   try {
  //     await ambulanceRef.add(ambulanceData); // Add data to Firestore
  //     print('Data successfully added to Firestore');

  //     // Clear the text fields after submission
  //     _problemController.clear();
  //     _locationController.clear();
  //     _vehicleTypeController.clear();

  //     // Optionally, show a Snackbar or dialog
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Ambulance data submitted successfully!'),
  //     ));
  //   } catch (e) {
  //     print('Error adding data: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Failed to submit data!'),
  //     ));
  //   }
  // }

  //2for ambulance main
   Future<void> _checkAvailabilityA() async {
    final mechanicRef = FirebaseFirestore.instance.collection('Ambulance');

    final mechanicData = {
       //'Problem': _problemController.text,
      'Location': _locationController.text,
       //'Vehicle Type': _vehicleTypeController.text,
     };
     await mechanicRef.add(mechanicData); // Add data to Firestore
  //     print('Data successfully added to Firestore');

    if (//_problemController.text.trim().isNotEmpty &&
        _locationController.text.trim().isNotEmpty //&&
        //_vehicleTypeController.text.trim().isNotEmpty
        ) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Availabilityambulance(
          userLocation: _locationController.text.trim(),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    } 
  }


  void mechanicBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
            child: SizedBox(
              height: 350,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Mechanic Problem",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _problemController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Problem",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your location",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _vehicleTypeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Select your Vehicle Type",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (_problemController.text.trim().isNotEmpty &&
                            _locationController.text.trim().isNotEmpty &&
                            _vehicleTypeController.text.trim().isNotEmpty) {
                          _checkAvailability();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => Availability(
                          //     userLocation: _locationController.text.trim(),
                          //   ),
                          // )
                          // );
                        } else {
                          CustomSnackbar.showCustomSnackbar(
                            context: context,
                            message: 'Please fill in all fields',
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Center(
                          child: Text(
                            "Check Availability",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void ambulanceBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Ambulance",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     controller: _problemController,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter your Problem",
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Location",
                      ),
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter your Problem",
                  //     ),
                  //   ),
                  // ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (
                          // _problemController.text.trim().isNotEmpty &&
                            _locationController.text.trim().isNotEmpty) {
                          _checkAvailabilityA();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const Availabilityambulance(userLocation: '',),
                          // )
                          // );
                        } else {
                          // CustomSnackbar();
                          CustomSnackbar.showCustomSnackbar(
                            context: context,
                            message: 'Please fill the all Fields',
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            "Check Availability",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void toingBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
            child: SizedBox(
              height: 350,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Toing Van",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _problemController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Problem",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Location",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _vehicleTypeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Vehicle type",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (_problemController.text.trim().isNotEmpty &&
                            _locationController.text.trim().isNotEmpty &&
                            _vehicleTypeController.text.trim().isNotEmpty) {
                          _checkAvailabilityt();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const Availability(
                          //     userLocation: '',
                          //   ),
                          // )
                          // );
                        } else {
                          // CustomSnackbar();
                          CustomSnackbar.showCustomSnackbar(
                            context: context,
                            message: 'Please fill the all Fields',
                          );
                        }
            
                        // if(userType[])
                        // if(userData!['Location'] == mechanicData!['Location'] ){
            
                        // } else {
            
                        // }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            "Check Availability",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void trafficPBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: 220,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Traffic Police",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     controller: _problemController,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter your Problem",
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Location",
                      ),
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter your Problem",
                  //     ),
                  //   ),
                  // ),
            
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 20, left: 8, right: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (
                          // _problemController.text.trim().isNotEmpty &&
                            _locationController.text.trim().isNotEmpty) {
                          _checkAvailabilitytf();
                      
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const Availability(
                          //     userLocation: '',
                          //   ),
                          // )
                          // );
                        } else {
                          // CustomSnackbar();
                          CustomSnackbar.showCustomSnackbar(
                            context: context,
                            message: 'Please fill the all Fields',
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            "Check Availability",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  //int _selectedIndex = 0;
  // static const List _pages=[
  //   Center(child:Text('Home Page')),
  //   Center(child:Text('Search Page')),
  //   Center(child:Text('Profile Page')),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      //  myBottomSheet();
      // } if(Colors.blue==true){
      //
      _selectedIndex = index;
    });
  }

  Widget _buildCircularIcon(IconData icon, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? const Color.fromRGBO(52, 111, 249, 1)
            : Colors.grey[300], // Change color if active
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.black54,
        size: 24,
      ),
    );
  }

  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _startAutoScroll();
  // }

  Map<String, dynamic>? userData;
  bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchUserData();
  // }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//User cha mhnje Customer Cha data fetch karnyasathi chi method
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

// //  late final String userLocation;
//  //mechanic cha data fetch karnyasathi method
//   Future<List<Map<String, dynamic>>> fetchMechanics() async {
//     // final String? userLocation;
//     QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('userType', isEqualTo: 'serviceProvider')
//         .where('location', isEqualTo: widget.userLocation) // Filter by user's location
//         .get();

//     return querySnapshot.docs.map((doc) {
//       return {
//         'id': doc.id,
//         ...doc.data(),
//       };
//     }).toList();
//   }
  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(5); // Reset to the beginning
        } else {
          _scrollController.animateTo(
            currentScroll +
                MediaQuery.of(context).size.width, // Scroll by 150 pixels
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  List<String> images1 = [
    "https://media.istockphoto.com/id/478107962/photo/auto-parts.jpg?s=612x612&w=0&k=20&c=C31mE-cVYFlLqJp9smDKUczPoBEtoYl5gaGxdvH0lmM=",
    "https://m.media-amazon.com/images/I/61BKfsVKtYL.jpg",
    "https://www.shutterstock.com/image-photo/sport-car-tuning-equipment-accessories-600nw-2221101627.jpg",
    "https://images.unsplash.com/photo-1611633859589-7990d2fbb56b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FyJTIwcGFydHN8ZW58MHx8MHx8fDA%3D",
    "https://www.shutterstock.com/image-photo/wheel-alloy-wheels-rim-mag-600nw-1875750850.jpg",
  ];

  List<String> images2 = [
    "https://m.media-amazon.com/images/S/al-na-9d5791cf-3faf/4951c199-cf7c-42b5-981e-84dde83494a8._SL480_.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCyYGuXfdg1PLRwC2lGYfia3oZeU8wdJblditO7u1Nr4OOIBlpDd1TdjDQa_OeB4fp60w&usqp=CAU",
    "https://media.istockphoto.com/id/1333328051/photo/man-installs-a-child-car-seat-in-car-at-the-back-seat-responsible-father-thought-about-the.jpg?s=612x612&w=0&k=20&c=3_DNjNdTFYhNAF51JHADcYfKhbqvjhyzSdiRwitRFTA=",
    "https://media.istockphoto.com/id/1165311626/photo/mechanic-using-a-ratchet-wrench.jpg?s=612x612&w=0&k=20&c=D4XCHr8BeR44hdJXS_Tp-9djQ7jWDKKkBWSKaqhuqK8=",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8z2rlBahGkRDhhXRK_kU5bIc8uG2QfhyxJQm3UuEWK109Sr4IEJTsfgIyiJbmh5JjmOc&usqp=CAU",
  ];

  List<String> images3 = [
    "https://watermark.lovepik.com/photo/20211207/large/lovepik-car-insurance-concept-illustration-picture_501540487.jpg",
    "https://www.shutterstock.com/image-photo/businessman-offering-cargo-delivery-truck-260nw-1492435208.jpg",
    "https://www.shutterstock.com/image-photo/motorbike-insurance-concept-businessman-protective-260nw-1394162840.jpg",
    "https://cdn.prod.website-files.com/66225dcd2e895941e4c2500e/6655edbd0bb56046571ce710_long-bus-trip-img-1.webp",
    "https://st3.depositphotos.com/1010613/18526/i/450/depositphotos_185262058-stock-photo-close-human-hand-placing-small.jpg",
  ];

  List<String> images4 = [
    "https://img.lovepik.com/photo/50771/7315.jpg_wh300.jpg",
    "https://steamuserimages-a.akamaihd.net/ugc/2041863131297155885/F703B1F047B17C0AF7CAD00716A68B06E060B646/?imw=1024&imh=576&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true",
    "https://static.vecteezy.com/system/resources/previews/029/305/778/non_2x/moving-forward-bus-travels-on-road-embracing-travel-time-ambiance-ai-generated-photo.jpg",
    "https://cdn.shopify.com/s/files/1/0762/7194/3984/files/2.4-sport-touring-motorcycles.jpg?v=1727116731",
    "https://watermark.lovepik.com/photo/20211210/large/lovepik-young-friends-outdoor-self-driving-tour-picture_501799850.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            ///it describes which serives we are going to offer to user in our app. eg. bike repairing,
            ///emergency hospital serivce, police calling etc. for that purpose we have created some empty
            ///containers.
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "welcome back",
                            style: GoogleFonts.aleo(fontSize: 15),
                          ),
                          Row(
                            children: [
                              Text(
                                "Hii, ",
                                style: GoogleFonts.aleo(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${userData!['firstName']}",
                                style: GoogleFonts.aleo(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const UserProfileScreen()),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black)),
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
          
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Image.network(
                          "https://scontent.fpnq9-1.fna.fbcdn.net/v/t1.6435-9/42500842_319140252228850_4862743714625224704_n.jpg?stp=dst-jpg_s960x960&_nc_cat=107&ccb=1-7&_nc_sid=2285d6&_nc_ohc=OJgZVaZtCroQ7kNvgFG7JIq&_nc_zt=23&_nc_ht=scontent.fpnq9-1.fna&_nc_gid=AQTTzaK-M3OBH5gXli4YGCr&oh=00_AYC3PVnOuV32-yEz4i2prgbt28rIeEyBcws47yFknLCn5g&oe=67686968",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          
                  Text(
                    "Accesories",
                    style: GoogleFonts.aleo(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
          
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images1.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const BuyNow(),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    // Top Image Container with Shadow
                                    Container(
                                      height: 130,
                                      width: 145,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 36, 35, 35),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.yellow, width: 1),
                                        boxShadow: const [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 67, 66, 66),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(images1[index],
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    // Bottom Text Container with Shadow
                                    Container(
                                      width: 145,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(52, 111, 249, 1),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 67, 66, 66),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(5, 4),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, right: 5, left: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Accessories Name",
                                              style: GoogleFonts.quicksand(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "Price\$23",
                                              style: GoogleFonts.quicksand(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images2.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BuyNow()));
                                        },
                                        child: Container(
                                          height: 130,
                                          width: 145,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 67, 66, 66),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: Offset(5, 5),
                                              ),
                                            ],
          
                                            color: const Color.fromARGB(
                                                255, 36, 35, 35),
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.yellow, width: 1),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.purple
                                            //         .withOpacity(0.6),
                                            //     spreadRadius: 1,
                                            //     blurRadius: 1,
                                            //     offset: const Offset(4, 4),
                                            //   ),
                                            // ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            child: Image.network(images2[index],
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 145,
                                        // height: 40,
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 67, 66, 66),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(5, 4),
                                              ),
                                            ],
                                            color:
                                                Color.fromRGBO(52, 111, 249, 1),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Accessories Name",
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "Price\$23",
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
          
                  // BottomSheet(onClosing: (){}, builder:( builder){
          
                  // ta})
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Insurance",
                      style: GoogleFonts.aleo(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 145,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: images3.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5, top: 10),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                height: 145,
                                width:
                                    MediaQuery.of(context).size.width - 20, //350,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 36, 35, 35),
                                  // borderRadius: const BorderRadius.all(
                                  //     Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                child: ClipRRect(
                                  // borderRadius: const BorderRadius.all(
                                  //     Radius.circular(10)),
                                  child: Image.network(images3[index],
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Rent Vehicle",
                      style: GoogleFonts.aleo(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 145,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                height: 145,
                                width:
                                    MediaQuery.of(context).size.width - 40, //350,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 36, 35, 35),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                  child: Image.network(images4[index],
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),

        ////Bottom Navigation Bar
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildCircularIcon(Icons.home, isActive: _selectedIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  setState(() {
                    mechanicBottomSheet();
                  });
                },
                child: _buildCircularIcon(Icons.build,
                    isActive: _selectedIndex == 1)),
            label: 'Mechanic',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  ambulanceBottomSheet();
                  // myBottomSheet();
                  // mechanicBottomSheet();
                });
              },
              child: _buildCircularIcon(FontAwesomeIcons.truckMedical,
                  isActive: _selectedIndex == 2),
            ),
            label: 'Ambulance',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  // myBottomSheet();
                  toingBottomSheet();
                });
              },
              child: _buildCircularIcon(Icons.local_shipping_outlined,
                  isActive: _selectedIndex == 3),
            ),
            label: 'Toing Van',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  // myBottomSheet();
                  toingBottomSheet();
                });
              },
              child: GestureDetector(
                onTap: () {
                  trafficPBottomSheet();
                },
                child: _buildCircularIcon(Icons.local_police,
                    isActive: _selectedIndex == 4),
              ),
            ),
            label: 'Traffic police',
          ),
        ],
      ),
    ); //_pages[_selectedIndex],
  }
}
