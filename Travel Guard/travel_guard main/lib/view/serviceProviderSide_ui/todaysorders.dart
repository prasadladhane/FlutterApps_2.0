import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodayOrdersPage extends StatelessWidget {
  final String mechanicId;

  // const TodayOrdersPage({Key? key, required this.mechanicId}) : super(key: key);
  const TodayOrdersPage({super.key,required this.mechanicId});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime todayStart = DateTime(now.year, now.month, now.day);
    final DateTime todayEnd = todayStart.add(const Duration(days: 1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Orders'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(mechanicId)
            .collection('requests')
            .where('requestTime', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
            .where('requestTime', isLessThan: Timestamp.fromDate(todayEnd))
            .orderBy('requestTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders for today.'));
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index].data();

              final problem = request['Problem'] ?? 'Unknown';
              final location = request['Location'] ?? 'Unknown';
              final vehicleType = request['Vehicle Type'] ?? 'Unknown';
              final requestTime = request['requestTime'] as Timestamp?;
              final formattedTime = requestTime != null
                  ? DateTime.fromMillisecondsSinceEpoch(requestTime.millisecondsSinceEpoch)
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
                      Text("Time: $formattedTime"),
                    ],
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