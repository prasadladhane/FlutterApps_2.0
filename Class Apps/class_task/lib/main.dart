import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyApp();
}

class _MyApp extends State {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shoes",
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          actions:const [
            Icon(Icons.shopping_cart),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height:400,
              child: Image.network(
                  "https://app.vectary.com/website_assets/636cc9840038712edca597df/636cc9840038713d9aa59ac2_UV_hero.jpg",
                  fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  const SizedBox(
                    width: 180,
                    height: 30,
                    child: Text(
                      "Nike Air Force 1' 07",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        ),
                        child: const Text(
                          "SHOES",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        ),
                        child: const Text(
                          "FOOTWEAR",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "A shoe is an item of footwear intended to protect and comfort the human foot A shoe is an item of footwear intended to protect and comfort the human foot",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Quantity",style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap:(){
                          count++;
                          setState((){});
                        },
                        child: const Icon(Icons.add)),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height:23,width:23,
                        alignment:Alignment.center,
                        decoration:BoxDecoration(
                        border:Border.all(
                          color:Colors.grey,width:2
                        )
                        ),
                        child:Text("${count++}")
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap:(){
                          count--;
                          setState((){});},
                       
                        child: const Icon(Icons.remove))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      child: const Text(
                        "PURCHASE",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
