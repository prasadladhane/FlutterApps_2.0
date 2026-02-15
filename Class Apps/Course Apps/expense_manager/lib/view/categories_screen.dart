import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:google_fonts/google_fonts.dart";

class CategoriesUi extends StatefulWidget{
  const CategoriesUi({super.key});

  @override
  State createState()=>_CategoriesUiState();
}
class _CategoriesUiState extends State{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/menu_graph.svg",height: 24,width:24,),
                  Padding(
                    padding: const EdgeInsets.only(left:30),
                    child: Text(
                      "Categories",
                      style:GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    
                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}