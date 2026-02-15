import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registerpage/model/funct_model/fetch_customer_data.dart';
import '../../model/funct_model/database_helper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    // Sync Firestore data to Sqflite
    await syncDataFromFirestoreToSqflite();

    // Fetch notifications from Sqflite
    List<Map<String, dynamic>> data =
        await DatabaseHelper.instance.fetchNotifications();
    setState(
      () {
        notifications = data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.quicksand(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color.fromRGBO(27, 48, 101, 1),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text("No notifications available"),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(notification['customerName'] ?? "Unknown"),
                  subtitle: Text(notification['reason'] ?? "No reason"),
                  trailing: Text(notification['requestBy'] ?? "Unknown"),
                );
              },
            ),
    );
  }
}
