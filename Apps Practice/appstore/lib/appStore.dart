import "package:flutter/material.dart";

class AppStore extends StatefulWidget{
  // const AppStore({super.key});
  @override 
  State createState() => _AppStore();
}
class _AppStore extends State{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Search",
        style:TextStyle(
          fontSize:30,
          fontWeight:FontWeight.w900
        )
        ),
        actions: [
          Icon(Icons.person,size: 30,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height:25,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        const SizedBox(width: 3,),
                        const Text("Games, Apps, Stories and More"),
                        Spacer(),
                        Icon(Icons.mic)
                      ],
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Row(
                    children: [
                      const Text("Suggested",
                      style:TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900
                      )
                      ),
                      const SizedBox(width:3),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: SizedBox(
                    height:330,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height:90,
                                  width:90,
                                  child: Image.network("https://img.tapimg.net/market/images/115a50a762104f7ebe0eb76a1cccb29d.png/appicon?t=1")
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Evony",
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      const SizedBox(height:2),
                                      const Text("The Kings's Return"),
                                    ],
                                  ),
                                ),
                                const SizedBox(width:30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:40,
                                      width:60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:const Text("Get",style:TextStyle(color: Colors.blue,fontWeight: FontWeight.w800))
                                    ),
                                    const Text("In app purchase")
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
                      );
                      }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: Row(
                    children: [
                      const Text("Browse",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: Row(
                    children: [
                      Container(
                        height:175,
                        width:175,
                        decoration: BoxDecoration(
                          color:Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                      SizedBox(width:30),
                      Container(
                        height:175,
                        width:175,
                        decoration: BoxDecoration(
                          color:Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      )
                    ],
                  ),
                ),
                    Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: Row(
                    children: [
                      Container(
                        height:175,
                        width:175,
                        decoration: BoxDecoration(
                          color:Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                      SizedBox(width:30),
                      Container(
                        height:175,
                        width:175,
                        decoration: BoxDecoration(
                          color:Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}