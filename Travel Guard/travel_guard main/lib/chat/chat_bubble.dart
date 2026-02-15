import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget{
  final String message;
  const ChatBubble({super.key,required this.message});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color:Colors.black ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.purple
      ),
      child: Text(message,style: GoogleFonts.quicksand(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),),
    );
  }
}