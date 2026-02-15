// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ChatScreen extends StatefulWidget {
//   final String senderUserEmail;
//   final String senderUserId;
//   final String senderType; // 'user' or 'serviceProvider'
//   final String recipientName;
//   final String recipientPhone;

//   const ChatScreen({
//     super.key,
//     required this.senderUserEmail,
//     required this.senderUserId,
//     required this.senderType,
//     required this.recipientName,
//     required this.recipientPhone,
//   });

//   @override
//   State createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final CollectionReference _messages =
//       FirebaseFirestore.instance.collection('messages');
//   final ScrollController _scrollController = ScrollController();

//   bool isNightTheme = false;

//   Future<void> _makeCall(String number) async {
//     try {
//       final Uri callUri = Uri(scheme: 'tel', path: number);
//       if (await canLaunchUrl(callUri)) {
//         await launchUrl(callUri);
//       } else {
//         // Log additional information for debugging purposes
//         log('Cannot launch call to $number. Uri: $callUri');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Unable to make a call to $number")),
//         );
//       }
//     } catch (e) {
//       // Catch and log any unexpected errors
//       log('Error attempting to make a call: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text("An error occurred while trying to call $number")),
//       );
//     }
//   }

//   void _showCallPopup() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "Call ${widget.recipientName}",
//             style: GoogleFonts.inter(fontWeight: FontWeight.bold),
//           ),
//           content: Text(
//             "Phone: ${widget.recipientPhone}",
//             style: GoogleFonts.inter(),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 "Cancel",
//                 style: GoogleFonts.inter(color: Colors.red),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _makeCall(widget.recipientPhone);
//               },
//               child: Text(
//                 "Call",
//                 style: GoogleFonts.inter(),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Define colors based on theme
//     final Color backgroundColor = isNightTheme ? Colors.black : Colors.white;
//     final Color appBarColor = isNightTheme
//         ? const Color(0xFF282846)
//         : const Color.fromRGBO(27, 48, 101, 1);
//     final Color iconColor =
//         isNightTheme ? Colors.white : const Color(0xFF00457C);
//     final Color topColor =
//         isNightTheme ? const Color(0xFF1E1E2C) : const Color(0xFFB1D7F0);
//     final Color bottomColor =
//         isNightTheme ? const Color(0xFF282846) : const Color(0xFFFFF5D1);
//     final Color textFieldColor =
//         isNightTheme ? const Color(0xFF393955) : const Color(0xFFF6F6F6);
//     final Color inputTextColor = isNightTheme ? Colors.white : Colors.black;
//     final Color messageTextColor = isNightTheme ? Colors.white : Colors.black;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Icon(Icons.arrow_back_ios,
//               color: isNightTheme ? Colors.white : Colors.white),
//         ),
//         title: Row(
//           children: [
//             Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(90),
//                 border: Border.all(width: 1, color: Colors.white),
//               ),
//               child: ClipOval(
//                 child: Image.network(
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZ2z7m8dPUdZVFVgAVcUca45bpv3HiDMcjA&s",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               widget.recipientName,
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//                 color: isNightTheme ? Colors.white : Colors.white,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.call, color: Colors.white),
//             onPressed: _showCallPopup,
//           ),
//           IconButton(
//             icon: Icon(isNightTheme ? Icons.sunny : Icons.nightlight_round,
//                 color: Colors.white),
//             onPressed: () {
//               setState(() {
//                 isNightTheme = !isNightTheme;
//               });
//             },
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Chat messages section
//             Expanded(
//               child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [topColor, bottomColor],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                   child: StreamBuilder(
//                     stream: _messages
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       // Check connection state
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         log('Loading data...');
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       // Check for errors
//                       if (snapshot.hasError) {
//                         log('Error fetching data: ${snapshot.error}');
//                         return const Center(
//                             child: Text('Error fetching messages.'));
//                       }

//                       // Check if data exists
//                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                         log('No messages in the Firestore');
//                         return const Center(
//                             child: Text('No messages available.'));
//                       }

//                       // Successfully fetched data
//                       log('Data fetched: ${snapshot.data!.docs.length} messages');
//                       return ListView(
//                         reverse: true,
//                         controller: _scrollController,
//                         children: snapshot.data!.docs.map((doc) {
//                           bool isSender =
//                               doc['senderId'] == widget.senderUserId;
//                           return Align(
//                             alignment: isSender
//                                 ? Alignment.centerRight
//                                 : Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.all(6),
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     vertical: 5, horizontal: 10),
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   gradient: isSender
//                                       ? LinearGradient(colors: [
//                                           const Color(0xFF99C1D9),
//                                           isNightTheme
//                                               ? const Color(0xFF1E1E2C)
//                                               : const Color(0xFF00457C)
//                                         ])
//                                       : LinearGradient(colors: [
//                                           const Color(0xFFF6F6F6),
//                                           isNightTheme
//                                               ? const Color(0xFF393955)
//                                               : const Color(0xFFD9D9D9)
//                                         ]),
//                                   borderRadius: BorderRadius.circular(15),
//                                   border: Border.all(
//                                       width: 2, color: const Color(0xFF00457C)),
//                                 ),
//                                 child: Text(
//                                   doc['message'],
//                                   style: GoogleFonts.inter(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: messageTextColor),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   )),
//             ),
//             // Message input section
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               color: textFieldColor,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       style: TextStyle(color: inputTextColor),
//                       decoration: InputDecoration(
//                         hintText: "Type a message",
//                         hintStyle: TextStyle(
//                             color: isNightTheme ? Colors.grey : Colors.black54),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.grey.shade400),
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.send, color: iconColor),
//                     onPressed: () async {
//                       if (_messageController.text.trim().isNotEmpty) {
//                         await _messages.add({
//                           'message': _messageController.text.trim(),
//                           'senderId': widget.senderUserId,
//                           'senderType': widget
//                               .senderType, // Either 'user' or 'serviceProvider'
//                           'timestamp': FieldValue
//                               .serverTimestamp(), // Ensure this is set correctly
//                         });
//                         _messageController.clear();
//                         _scrollController
//                             .jumpTo(_scrollController.position.minScrollExtent);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final String senderUserEmail;
  final String senderUserId;
  final String senderType; // 'user' or 'serviceProvider'
  final String recipientName;
  final String recipientPhone;

  const ChatScreen({
    super.key,
    required this.senderUserEmail,
    required this.senderUserId,
    required this.senderType,
    required this.recipientName,
    required this.recipientPhone,
  });

  @override
  State createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final CollectionReference _messages =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference _pastChats =
      FirebaseFirestore.instance.collection('pastChats');
  final ScrollController _scrollController = ScrollController();

  bool isNightTheme = false;

  Future<void> _makeCall(String number) async {
    try {
      final Uri callUri = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        log('Cannot launch call to $number. Uri: $callUri');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unable to make a call to $number")),
        );
      }
    } catch (e) {
      log('Error attempting to make a call: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred while trying to call $number")),
      );
    }
  }

  Future<void> _endChat() async {
    try {
      QuerySnapshot messagesSnapshot =
          await _messages.orderBy('timestamp', descending: false).get();

      if (messagesSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in messagesSnapshot.docs) {
          await _pastChats.add({
            'message': doc['message'],
            'senderId': doc['senderId'],
            'senderType': doc['senderType'],
            'timestamp': doc['timestamp'],
          });
          await doc.reference.delete(); // Delete each message after moving it
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Chat ended and moved to past chats.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No messages to end.")),
        );
      }
    } catch (e) {
      log('Error ending chat: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isNightTheme ? const Color(0xFF1E1E2C) : Colors.white;
    final Color appBarColor =
        isNightTheme ? const Color(0xFF282846) : Colors.pink;
    final Color iconColor =
        isNightTheme ? const Color(0xFFE3B505) : const Color(0xFF00457C);
    final Color topColor =
        isNightTheme ? const Color(0xFF1E1E2C) : const Color(0xFFB1D7F0);
    final Color bottomColor =
        isNightTheme ? const Color(0xFF282846) : const Color(0xFFFFF5D1);
    final Color textFieldColor =
        isNightTheme ? const Color(0xFF393955) : const Color(0xFFF6F6F6);
    final Color inputTextColor = isNightTheme ? Colors.white : Colors.black;
    final Color messageTextColor = isNightTheme ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios,
              color: isNightTheme ? Colors.white : Colors.black),
        ),
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(90),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: ClipOval(
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZ2z7m8dPUdZVFVgAVcUca45bpv3HiDMcjA&s",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.recipientName,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isNightTheme ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed:()=> _makeCall(widget.recipientPhone),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _endChat,
          ),
          IconButton(
            icon: Icon(
                isNightTheme ? Icons.sunny : Icons.nightlight_round,
                color: Colors.white),
            onPressed: () {
              setState(() {
                isNightTheme = !isNightTheme;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat messages section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [topColor, bottomColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: StreamBuilder(
                  stream: _messages.orderBy('timestamp', descending: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching messages.'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No messages available.'));
                    }
                    return ListView(
                      reverse: true,
                      controller: _scrollController,
                      children: snapshot.data!.docs.map((doc) {
                        bool isSender = doc['senderId'] == widget.senderUserId;
                        return Align(
                          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: isSender
                                    ? LinearGradient(colors: [
                                        const Color(0xFF99C1D9),
                                        isNightTheme
                                            ? const Color(0xFF1E1E2C)
                                            : const Color(0xFF00457C)
                                      ])
                                    : LinearGradient(colors: [
                                        const Color(0xFFF6F6F6),
                                        isNightTheme
                                            ? const Color(0xFF393955)
                                            : const Color(0xFFD9D9D9)
                                      ]),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2, color: const Color(0xFF00457C)),
                              ),
                              child: Text(
                                doc['message'],
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: messageTextColor),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
            // Message input section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: textFieldColor,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(color: inputTextColor),
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                            color: isNightTheme ? Colors.grey : Colors.black54),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: iconColor),
                    onPressed: () async {
                      if (_messageController.text.trim().isNotEmpty) {
                        await _messages.add({
                          'message': _messageController.text.trim(),
                          'senderId': widget.senderUserId,
                          'senderType': widget.senderType,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        _messageController.clear();
                        _scrollController.jumpTo(
                            _scrollController.position.minScrollExtent);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}