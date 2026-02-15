
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/model/ui_model/service_provider_chatbot.dart';
//import 'service_provider_chat_bot.dart';

class Availability extends StatefulWidget {
  final String userLocation;

  const Availability({Key? key, required this.userLocation, required String userproblem}) : super(key: key);

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  late Future<List<Map<String, dynamic>>> _mechanicsFuture;

  @override
  void initState() {
    super.initState();
    _mechanicsFuture = fetchMechanics();
  }

  Future<List<Map<String, dynamic>>> fetchMechanics() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('userType', isEqualTo: 'serviceProvider')
        .where('serviceType', isEqualTo: 'mechanic')
        .where('location', isEqualTo: widget.userLocation)
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data(),
      };
    }).toList();
  }

  Future<void> _sendRequestToMechanic(String mechanicId) async {
  try {
    // Retrieve the latest Problem, Location, and Vehicle Type from Firestore
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('mechanics')
        .orderBy('requestTime', descending: true) // Assuming 'requestTime' exists
        .limit(1) // Get the latest entry
        .get();

    if (snapshot.docs.isNotEmpty) {
      final mechanicData = snapshot.docs.first.data();

      // Prepare request data
      final requestData = {
        'Problem': mechanicData['Problem'],
        'Location': mechanicData['Location'],
        'Vehicle Type': mechanicData['Vehicle Type'],
        'requestTime': FieldValue.serverTimestamp(),
      };

      // Send the request to the service provider
      await FirebaseFirestore.instance
          .collection('users')
          .doc(mechanicId)
          .collection('requests')
          .add(requestData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request sent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No data available to send.')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to send request: $e')),
    );
  }
}

  void _navigateToChatScreen(String recipientName, String recipientPhone) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceProviderChatBot(
          recipientName: recipientName,
          recipientPhone: recipientPhone,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Available Mechanics",
          style: GoogleFonts.quicksand(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromRGBO(27, 48, 101, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _mechanicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No mechanics found for your location.'));
          }

          final mechanics = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: mechanics.length,
            itemBuilder: (context, index) {
              final mechanic = mechanics[index];
              final String name =
                  "${mechanic['firstName']} ${mechanic['lastName']}";
              final String phone = mechanic['mobile'] ?? 'N/A';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.black, width: 1),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: $name",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Phone: $phone",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sendRequestToMechanic(mechanic['id']);
                                _navigateToChatScreen(name, phone);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(52, 111, 249, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Contact",
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Distance: 5 km", // Placeholder distance
                              style: GoogleFonts.quicksand(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Time Required: 30 mins", // Placeholder time
                              style: GoogleFonts.quicksand(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
