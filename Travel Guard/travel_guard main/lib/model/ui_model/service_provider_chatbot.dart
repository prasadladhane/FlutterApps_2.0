
import 'package:flutter/material.dart';
import '../../view/chat_screen.dart';

class ServiceProviderChatBot extends StatelessWidget {
  final String recipientName;
  final String recipientPhone;

  const ServiceProviderChatBot({
    super.key,
    required this.recipientName,
    required this.recipientPhone,
  });

  @override
  Widget build(BuildContext context) {
    return ChatScreen(
      senderUserEmail: 'provider@example.com',
      senderUserId: 'provider456',
      senderType: 'serviceProvider',
      recipientName: recipientName,
      recipientPhone: recipientPhone,
    );
  }
}
