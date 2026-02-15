import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlashScreen extends StatefulWidget{
  const FlashScreen({super.key});

  @override 
  State createState()=>_FlashScreenState();
}
class _FlashScreenState extends State{




  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            Center(
              child: Container(
                height:144,
                width:144,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color:Color.fromRGBO(234,238,235,1),
                ),
                child:Image.asset("assets/images/flash screen.png"),
              ),
            ),
            const SizedBox(height:357),
            Text(
              "Expense Manager",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer()
          ],
        )
      ),
    );
  }
}