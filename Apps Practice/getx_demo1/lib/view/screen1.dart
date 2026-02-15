import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:getx_demo1/controller/cart_controller.dart";
import "package:getx_demo1/model/product.dart";
import "package:getx_demo1/view/screen2.dart";

class Screen1 extends StatefulWidget{
  const Screen1({super.key});
  
  @override
  State createState()=>_Screen1State();
}
class _Screen1State extends State{

  final CartController cartController=Get.put(CartController());

  final List products=[
    Product(name: "Shoes", price: 1000),
    Product(name: "T-shirt", price: 1000),
    Product(name: "Watch", price: 1000),
    Product(name: "Jeans", price: 1000),
  ];


  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:const Text("Products"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(Screen2());
            },
            child: Obx(() => Stack(
              children: [
              const Icon(Icons.shopping_cart),
              if (cartController.cartItems.isNotEmpty)
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    cartController.cartItems.length.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
          )
        ],
      ),
      body:ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product=products[index];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Row(
                      children: [
                        Text(product.name),
                        const SizedBox(width:25),
                        Text("${product.price.toStringAsFixed(2)}"),
                      ],
                    ),
                    const SizedBox(height:10),
                    ElevatedButton(
                      onPressed: ()=>cartController.addToCart(product), 
                      child: Icon(Icons.add_shopping_cart)
                    )
                  ]
                )
              ],
            ),
          );
        },
      )
    );
  }
}