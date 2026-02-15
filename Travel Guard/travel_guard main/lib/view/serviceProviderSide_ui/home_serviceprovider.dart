
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:registerpage/view/serviceProviderSide_ui/todaysorders.dart';
import 'package:registerpage/model/ui_model/user_chatbot.dart';
import 'package:registerpage/view/userSide_ui/user_profile.dart';

class ServiceProviderHome extends StatefulWidget {
  //const ServiceProviderHome({Key? key}) : super(key: key);
  const ServiceProviderHome({super.key});

  @override
  State<ServiceProviderHome> createState() => _ServiceProviderHomeState();
}

class _ServiceProviderHomeState extends State<ServiceProviderHome> {
  late String _mechanicId;
  bool _isTapped4 = false;

  @override
  void initState() {
    super.initState();
    _mechanicId = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> _deleteRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_mechanicId)
          .collection('requests')
          .doc(requestId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request deleted successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests for You'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.calendar_today),
        //     onPressed: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => TodayOrdersPage(mechanicId: _mechanicId),
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_mechanicId)
            .collection('requests')
            .orderBy('requestTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No requests found.'));
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final requestData = request.data();

              final problem = requestData['Problem'] ?? 'Unknown';
              final location = requestData['Location'] ?? 'Unknown';
              final vehicleType = requestData['Vehicle Type'] ?? 'Unknown';
              final requestTime = requestData['requestTime'] as Timestamp?;
              final formattedTime = requestTime != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                          requestTime.millisecondsSinceEpoch)
                      .toLocal()
                      .toString()
                      .substring(0, 16)
                  : 'Time not available';

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("Problem: $problem"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location: $location"),
                      Text("Vehicle Type: $vehicleType"),
                      const SizedBox(height: 10),
                      Text("Time: $formattedTime"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const UserChatBot(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.message,
                            color: Colors.blue,
                          )
                        ),
                      const SizedBox(width:5),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteRequest(request.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          // Home Page Navigation Bar
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        TodayOrdersPage(mechanicId: _mechanicId),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
              ),
            ),
            label: 'Todays order',
          ),

          // Profile Page Navigation Bar
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _isTapped4 = !_isTapped4;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserProfileScreen()));
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.person_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 158, 158, 158),
      ),
    );
  }
}