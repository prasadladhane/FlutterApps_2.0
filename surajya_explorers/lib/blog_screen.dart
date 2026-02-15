import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogScreen extends StatefulWidget{
  const BlogScreen({super.key});

  @override
  State createState()=>_BlogScreenState();
}
class _BlogScreenState extends State{

  final TextEditingController _commentController=TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new_rounded,color:Color.fromRGBO(34, 52, 36, 1),size:28,),
        title: Text(
          "Blog",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(34, 52, 36, 1)
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:15),
            child: Icon(Icons.share,color: Color.fromRGBO(34, 52, 36, 1),),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monsoon Trek Experience",
              style:GoogleFonts.poppins(
                color: Color.fromRGBO(34, 52, 36, 1),
                fontSize: 32,
                fontWeight: FontWeight.w600
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Container( 
                clipBehavior: Clip.antiAlias,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child:Image.network("https://static.vecteezy.com/system/resources/previews/006/066/678/non_2x/dark-path-in-the-forest-green-landscape-forest-background-free-photo.jpg")
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Text("Monsoon Trek Experince",
              style:GoogleFonts.poppins(
                color: Color.fromRGBO(34, 52, 36, 1),
                fontSize: 16,
                fontWeight: FontWeight.w500
              )),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top:10),
                child: Text(
                  "I recently went on a challenging monsoon trek in the Western Ghats. The trail was steep and slippery, with dense vegetation all around. As the rain poured down, I navigated through the mist, encountering breathtaking views of the surrounding mountains. The earthy smell of rain-soaked soil filled the air, and the sound of waterfalls created a constant, soothing backdrop. Despite the tough conditions, the trek was exhilarating and unforgettable. More...",
                  style:GoogleFonts.poppins(
                    color: Color.fromRGBO(34, 52, 36, 1),
                    fontSize: 14
                    )
                  ),
              )
              ),
              Padding(
                padding: const EdgeInsets.only(top:20),
                child: Row(
                  children: [
                    Icon(Icons.favorite_outline,color:Color.fromRGBO(34, 52, 36, 1),),
                    Padding(
                      padding: const EdgeInsets.only(left:8),
                      child: Icon(Icons.chat_bubble_outline,color:Color.fromRGBO(34, 52, 36, 1),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Icon(Icons.share_outlined,color:Color.fromRGBO(34, 52, 36, 1),),
                    ),
                    const Spacer(),
                    Icon(Icons.bookmark_border_outlined,color:Color.fromRGBO(34, 52, 36, 1),)
                  ],
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(top:10),
              child: Text("Leave a comment",
              style:GoogleFonts.poppins(
                color: Color.fromRGBO(34, 52, 36, 1),
                fontSize: 20,
                fontWeight: FontWeight.w500
              )),
            ),
            Container(
              height:60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child:TextField(
                controller: _commentController,
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: InputDecoration(
                  hintText: "Write a comment",
                  contentPadding: EdgeInsets.all(12),
                  // border: OutlineInputBorder()
                ),
              )
            ),
            const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 55,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(34, 52, 36, 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:const Text("Post",style:TextStyle(color:Colors.white))
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}