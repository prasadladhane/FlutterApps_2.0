
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registerpage/model/funct_model/database_helper.dart';

Future<void> syncDataFromFirestoreToSqflite() async {
  try {
    // Fetch data from Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();

    // Insert each document into Sqflite
    for (var doc in querySnapshot.docs) {
      await DatabaseHelper.instance.insertNotification({
        'id': doc.id, // Use Firestore document ID
        'customerName': doc['customerName'] ?? '',
        'reason': doc['reason'] ?? '',
        'requestBy': doc['requestBy'] ?? '',
      });
    }

    log("Data successfully synced from Firestore to Sqflite.");
  } catch (e) {
    log("Error syncing data: $e");
  }
}
