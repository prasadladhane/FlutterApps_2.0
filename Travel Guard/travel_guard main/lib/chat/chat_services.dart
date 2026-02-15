import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registerpage/model/funct_model/message_model.dart';

class ChatServices extends ChangeNotifier {
  // get instace of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message
  Future sendMessage(String receiverId, String message) async {

    // Get current user Info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // Create a new Message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timeStamp: timestamp,
    );

    // Construct chat room id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort the ids(this ensure the chatroom id is always the same for any pair of any two people)

    String chatRoomId = ids.join(
        "_"); //combine the ids into a single string to use as a chatroom ID

    // Add new message in database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    //  Get Messages
  }
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //construct chatroom id from user ids(sorted to ensure it matches the id used when sending messages)

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
      .collection('chat_rooms')
      .doc(chatRoomId)
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots();
  }
}


