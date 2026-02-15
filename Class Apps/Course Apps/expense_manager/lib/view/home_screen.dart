import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  final TextEditingController _dateEditingController=TextEditingController();
  final TextEditingController _amountEditingController=TextEditingController();
  final TextEditingController _categoryEditingController=TextEditingController();
  final TextEditingController _descriptionEditingController=TextEditingController();

 void _transactionBotttomSheeet(){
  showModalBottomSheet(
    isScrollControlled: true,
    context: context, 
    builder: (context){
      return Padding(
        padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height:434,
          width:MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius:BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
          ),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:22,top:30),
                  child: Text(
                    "Date",
                    style:GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:5,left:22,right:22),
                  child: SizedBox(
                    height:36,
                    width: 316,
                    child: TextField(
                      controller: _dateEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(191, 189, 189, 1),
                          // borderRadius:BorderRadius.all(Radius.circular(20))
                        )
                      ),
                    ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left:22,top:20),
                  child: Text(
                    "Amount",
                    style:GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:22,top:5,right:22),
                  child: SizedBox(
                    width: 316,
                    height:36,
                    child: TextField(
                        controller: _amountEditingController,
                        decoration:const InputDecoration(
                          border:  OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(191, 189, 189, 1),
                            // borderRadius:BorderRadius.all(Radius.circular(20))
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:22,top:20),
                  child: Text(
                    "Category",
                    style:GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:22,top:5,right:22),
                  child: SizedBox(
                    height: 36,
                    width: 316,
                    child: TextField(
                        controller: _categoryEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(191, 189, 189, 1),
                            // borderRadius:BorderRadius.all(Radius.circular(20))
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:22,top:20),
                  child: Text(
                    "Description",
                    style:GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:22,top:5,right:22),
                  child: SizedBox(
                    height: 36,
                    width: 316,
                    child: TextField(
                        controller: _descriptionEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(191, 189, 189, 1),
                            // borderRadius:BorderRadius.all(Radius.circular(20))
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:25,bottom:8,left: 45,right: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:40,
                        width:123,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(14, 161, 125, 1),
                          borderRadius: BorderRadius.all(Radius.circular(67)),
                          boxShadow:[
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(1, 2),
                              color: Color.fromRGBO(0, 0, 0, 0.4)
                            )
                          ]
                        ),
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      );
    }
  );
 }

  void _openDrawer(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _openDrawer();
                    },
                    child:const Icon(Icons.menu)
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "November 2024",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.keyboard_arrow_down)
                ],
              ),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Image.asset("assets/images/medicine.png"),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      // width: MediaQuery.of(context).size.width,
                                    width: 300,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Medicine",
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400
                                          )
                                        ),
                                        const Spacer(),
                                        Image.asset(
                                          "assets/images/Subtract.png"
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "400",
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400
                                    )
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Text(
                                          "3 June | 11:50 AM",
                                          style: GoogleFonts.poppins(
                                            color: const Color.fromRGBO(0, 0, 0, 0.6),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  );
                }
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom:40),
                child: GestureDetector(
                  onTap: () {
                    _transactionBotttomSheeet();
                  },
                  child: Container(
                    height:46,
                    width:166,
                    decoration: const BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(67))
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height:32,
                            width:32,
                            child: Image.asset("assets/images/transact_add.png"),
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            "Add Transaction",
                            style:GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            )
                          )
                        ],
                      ),
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
