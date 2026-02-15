import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import "ToDoModel.dart";
class ToDoApp extends StatefulWidget{
  const ToDoApp({super.key});
  
  @override

  State createState()=>_ToDoAppState();
}

class _ToDoAppState extends State{

  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController dateController=TextEditingController();

  List<ToDoModel> todoCards=[
    ToDoModel(
      title:"flutter",
      desc:"Dart, OOP",
      date:"18 Oct"
    ),
    ToDoModel(
      title:"flutter",
      desc:"Dart, OOP",
      date:"18 Oct"
    ),
    ToDoModel(
      title:"flutter",
      desc:"Dart, OOP",
      date:"18 Oct"
    )
  ];

  List<Color> colorSetList=[
    const Color.fromRGBO(250,232,232,1),
    const Color.fromRGBO(250,237,250,1),
    const Color.fromRGBO(250,249,232,1),
    const Color.fromRGBO(250,232,250,1),
   
  ];
  

  void clearController(){
    titleController.clear();
    descController.clear();
    dateController.clear();
  }

  void submit(bool doEdit,[ToDoModel? todoObj]){
    if(titleController.text.trim().isNotEmpty && 
    descController.text.trim().isNotEmpty && 
    dateController.text.trim().isNotEmpty  
    ){
      if(doEdit){

        todoObj!.title = titleController.text;
        todoObj.desc= descController.text; 
        todoObj.date= dateController.text;   
        
      }else{
        todoCards.add(
          ToDoModel(
            title: titleController.text, 
            desc: descController.text, 
            date: dateController.text
          ),
        );
      }
    }
    Navigator.of(context).pop();
    clearController();
    setState((){});
  }

 void showBottomSheet(bool doEdit,[ToDoModel? todoObj]){
  showModalBottomSheet(
    isScrollControlled:true,
    context:context,
    builder:(context){
      return Padding(
        padding:EdgeInsets.only(
          bottom:MediaQuery.of(context).viewInsets.bottom,
          top:12,
          left:12,
          right:12
        ),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisSize:MainAxisSize.min,
          children:[
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Text(
                  "Create Task",
                  style:GoogleFonts.quicksand(
                    fontSize:24,
                    fontWeight:FontWeight.w600,
                    color:Colors.black
                  ),
                ),
              ],
            ),

            //Text Field for title
            Text(
              "Title",
              style:GoogleFonts.quicksand(
                fontSize:24,
                fontWeight:FontWeight.w600,
                color:const Color.fromRGBO(0,139,148,1),
              )
            ),
            TextField(
              controller:titleController,
              decoration:InputDecoration(
                border:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color:Color.fromRGBO(0,139,148,1)
                  )
                )
              )
            ),
            const SizedBox(height:20),

            Text(
              "Description",
              style:GoogleFonts.quicksand(
                fontSize:24,
                fontWeight:FontWeight.w600,
                color:const Color.fromRGBO(0,139,148,1),
              )
            ),

            //Description TextField
            TextField(
              controller:descController,
              decoration:InputDecoration(
                border:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color:Color.fromRGBO(0,139,148,1)
                  )
                )
              )
            ),
            const SizedBox(height:20),

            Text(
              "Date",
              style:GoogleFonts.quicksand(
                fontSize:24,
                fontWeight:FontWeight.w600,
                color:const Color.fromRGBO(0,139,148,1),
              )
            ),
             //date TextField
            TextField(
              controller:dateController,
              decoration:InputDecoration(
                border:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color:Color.fromRGBO(0,139,148,1)
                  )
                ),
                suffixIcon:const Icon(
                  Icons.calendar_month_outlined,
                )
              ),
              onTap: ()async {
                DateTime? pickedDate = await showDatePicker(
                  context:context,
                  firstDate:DateTime(2024),
                  lastDate:DateTime(2025),
                );

                String formattedDate=DateFormat.yMMMd().format(pickedDate!);
                setState((){
                  dateController.text=formattedDate;
                });
              }
            ),
            const SizedBox(height:10),

            //Submit button

            Center(
              child:ElevatedButton(
                onPressed:(){
                  if(doEdit==true){
                    submit(true, todoObj);
                  }else{
                    submit(false);
                  }
                },
                style:const ButtonStyle(
                  backgroundColor:WidgetStatePropertyAll(
                    Color.fromRGBO(0,139,148,1),
                  )
                ),
                child:Text(
                  "Submit",
                  style:GoogleFonts.quicksand(
                    fontSize:20,
                    fontWeight:FontWeight.w700,
                    color:Colors.white,
                  )
                )
              )
            )
          ]
        )
      );
    }
  );
 }

  @override

  Widget build(BuildContext context){

    return Scaffold(
      appBar:AppBar(
        title:Text("To-Do List",
          style:GoogleFonts.quicksand(
            fontSize:26,
            fontWeight:FontWeight.w700,
            color:const Color.fromRGBO(255, 255, 255, 1),
          )
        ),
        backgroundColor:const Color.fromRGBO(2, 167, 177, 1),
      ),
      body:ListView.builder(
        padding:const EdgeInsets.symmetric(vertical:10),
        itemCount:todoCards.length,
        itemBuilder:(context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              Column(
                children:[
                  Container(
                    height:112,
                    width:330,
                    decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color:colorSetList[index]
                    ),
                    child:Column(
                      children:[
                        Row(
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height:52,
                                width:52,
                              
                                decoration:const BoxDecoration(
                                  //borderRadius:BorderRadius.circular(10),
                                  shape:BoxShape.circle,
                                  color:Color.fromRGBO(255,255,255,1),
                                ),
                                child:Image.asset("assets/Images/imageIcon.png"),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children:[
                                  Text(
                                    todoCards[index].title,
                                    style:GoogleFonts.quicksand(
                                      fontSize:12,
                                      fontWeight:FontWeight.w600,
                                    )
                                  ),
                                  Text(
                                    todoCards[index].desc,
                                    style:GoogleFonts.quicksand(
                                      fontSize:10,
                                      fontWeight:FontWeight.w500,
                                    )
                                  )
                                ]
                              ),
                            )
                          ]
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children:[
                              Text(todoCards[index].date,
                                style:GoogleFonts.quicksand(
                                  fontSize:10,
                                  fontWeight:FontWeight.w500,
                                  color:const Color.fromRGBO(132, 132, 132, 1)
                          
                                )
                              ),
                              const Spacer(),

                              ///edit icon
                              GestureDetector(
                                onTap:(){
                                  titleController.text=todoCards[index].title;
                                  descController.text=todoCards[index].desc;
                                  dateController.text=todoCards[index].date;
                                  showBottomSheet(
                                    true,
                                    todoCards[index],  
                                  );
                                  setState((){});
                                },
                                child: const Icon(Icons.edit,
                                size:13,
                                color:Color.fromRGBO(0, 139, 148, 1)
                                ),
                              ),
                              const SizedBox(width:10),

                              ///delete icon
                              GestureDetector(
                                onTap:(){
                                  todoCards.remove(todoCards[index]);
                                  setState(() { });
                                },
                                child: const Icon(Icons.delete,
                                size:13,
                                color:Color.fromRGBO(0, 139, 148, 1)
                                ),
                              ),
                            ]
                          ),
                        )
                      ]
                    )
                  )
                ]
              ),
            ],
          ),
        );
      },
      ),
      floatingActionButton:FloatingActionButton(  
        onPressed:(){
          showBottomSheet(false);
        },
        backgroundColor:const Color.fromRGBO(0,139,148,1),
        child:const Icon(Icons.add,color:Colors.white,size:45.5)
      )
    );
  }
}