// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Advanced_Todo extends StatefulWidget{
  const Advanced_Todo({super.key});

  @override

  State createState()=>_Advanced_TodoState();
}
class _Advanced_TodoState extends State{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111,81,255,1),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top:45,
              left:30
            ),
            child: Text(
              "Good morning",
              style: GoogleFonts.quicksand(
                fontSize: 22,
                fontWeight:FontWeight.w400,
                color:Colors.white
              ),
            ),
          ),
          Text(
            "Pathum",
            style: GoogleFonts.quicksand(
              fontSize:30,
              fontWeight: FontWeight.w600,
              color:Colors.white
            )
          ),
          Expanded(
            
              child: Container(
                decoration:const BoxDecoration(
                  borderRadius:BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color.fromRGBO(217,217,217,1),    
                ),
                child: Column(
                  children: [
                    Text(
                      "Create To Do List",
                      style:GoogleFonts.quicksand(
                        fontSize:12,
                        fontWeight: FontWeight.w500,
                        height: 5
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                        return Container(
                          decoration:const BoxDecoration(
                            borderRadius:BorderRadius.only(
                              topLeft:Radius.circular(40),
                              topRight:Radius.circular(40),
                            ),
                            color: Color.fromRGBO(255,255,255,1), 
                            boxShadow: [
                              BoxShadow(
                                color:Color.fromRGBO(0,0,0,0.16), 
                                offset: Offset(0, 4)
                              )
                            ]
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    decoration:const BoxDecoration(
                                      shape:BoxShape.circle,
                                    ),
                                    height:52,width:52,
                                    child:Image.asset("assets/Images/imageIcon.png"),
                                  ),
                                  const SizedBox(width:10),
                                  const Expanded(
                                    child: Column(
                                      children: [
                                        Text("Lorem ipsum is simply dummy industry"),
                                        SizedBox(height:10),
                                        Text("Simply dummy text of the printing and type setting industry. Lorem Ipsum Lorem Ipsum Lorem.")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      )
    );
  }
}