import 'package:flutter/material.dart';
import '../../view/chat_screen.dart';

class UserChatBot extends StatelessWidget {
  const UserChatBot({super.key});
  @override
  Widget build(BuildContext context) {
    return const ChatScreen(
      senderUserEmail: 'user@example.com',
      senderUserId: 'user123',
      senderType: 'user',
      recipientName: 'Nayan walunj',
      recipientPhone: '+919763825466',
    );
  } 
}
