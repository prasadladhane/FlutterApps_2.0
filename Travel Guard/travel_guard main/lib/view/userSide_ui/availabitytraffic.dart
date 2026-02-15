import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AvailabilityTraffic extends StatefulWidget {
  final String userLocation;

  // const AvailabilityTraffic({Key? key, required this.userLocation}) : super(key: key);
  const AvailabilityTraffic({super.key, required this.userLocation});

  @override

  State<AvailabilityTraffic> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<AvailabilityTraffic> {
  late Future<List<Map<String, dynamic>>> _ambulanceFuture;

  @override
  void initState() {
    super.initState();
    _ambulanceFuture = fetchAmbulances();
  }

  // Function to fetch ambulance service providers based on location
  Future<List<Map<String, dynamic>>> fetchAmbulances() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'serviceProvider')
        .where('serviceType', isEqualTo: 'Traffic Police')
        .where('location', isEqualTo: widget.userLocation) // Match location
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data(),
      };
    }).toList();
  }

  Future<void> _sendRequestToAmbulance(String ambulanceId) async {
    final requestData = {
      'Location': widget.userLocation,
    };

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ambulanceId)
          .collection('requests')
          .add(requestData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request sent successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send request: $e')),
      );
    }
  }

  Future<void> _makeCall(BuildContext context, String number) async {
    try {
      final Uri callUri = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unable to make a call to $number")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred while trying to call $number")),
      );
    }
  }

  void _showCallPopup(BuildContext context, String recipientName, String recipientPhone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Call $recipientName",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Phone: $recipientPhone"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _makeCall(context, recipientPhone);
              },
              child: const Text("Call"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Available Services",
          style: GoogleFonts.inter(
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
        future: _ambulanceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Service found for your location.'));
          }

          final ambulances = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: ambulances.length,
            itemBuilder: (context, index) {
              final ambulance = ambulances[index];
              final String name = "${ambulance['firstName'] ?? 'N/A'} ${ambulance['lastName'] ?? 'N/A'}";
              final String phone = ambulance['mobile'] ?? 'N/A';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
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
                                border: Border.all(color: Colors.grey, width: 1),
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
                                _sendRequestToAmbulance(ambulance['id']);
                                _showCallPopup(context, name, phone); // Show popup with name and phone
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "Contact",
                                  style: TextStyle(color: Colors.white),
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

