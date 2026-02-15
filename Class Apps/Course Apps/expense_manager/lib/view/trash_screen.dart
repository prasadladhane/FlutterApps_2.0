import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:google_fonts/google_fonts.dart";

class TrashUi extends StatefulWidget{
  const TrashUi({super.key});

  @override
  State createState()=>_TrashUiState();
}
class _TrashUiState extends State{

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
                      "Trash",
                      style:GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                // height:MediaQuery.of(context).size.width,
                height:750,
                child: ListView.builder(
                  itemCount: 30,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(
                                206, 206, 206, 1
                              )
                            )
                          )       
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(bottom:10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/images/sub_icon.svg"),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Medicine",
                                            style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400)
                                          ),
                                          const Spacer(),
                                          Text(
                                            "500",
                                            style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400)
                                          )
                                        ],
                                      ),
                                      Text(
                                        "Lorem Ipsum is simply dummy text of the printing \n and typesetting industry... more",
                                        style:GoogleFonts.poppins(
                                          color:const Color.fromRGBO(0, 0, 0, 0.8),
                                          fontSize:10,
                                          fontWeight: FontWeight.w400
                                        )
                                      ),
                                      const SizedBox(height: 8,),
                                      Row(children: [
                                        const Spacer(),
                                        Text(
                                          "3 June | 11:50 AM",
                                          style:GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(0, 0, 0, 0.6)
                                          )
                                        )
                                      ],)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                      const SizedBox(height:20)
                    ],
                  );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}