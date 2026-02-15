import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo1/controller/cart_controller.dart';

class Screen2 extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.blue,title: Text("Cart")),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text("Your cart is empty"));
        }
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final product = cartController.cartItems[index];
            return Card(
              child: ListTile(
                title: Text(product.name),
                subtitle: Text("₹${product.price.toStringAsFixed(2)}"),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () => cartController.removeFromCart(product),
                ),
              ),
            );
          },
        );
      },
      ),
  //     bottomNavigationBar: Obx(() => Container(
  //       padding: const EdgeInsets.all(12),
  //       color: Colors.white,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text("Total: ₹${cartController.totalPrice}",
  //           style: const TextStyle(fontWeight: FontWeight.bold)),
  //           ElevatedButton(
  //           onPressed: () {
  //           // Navigate to payment or address
  //           },
  //           child: const Text("Checkout"),
  //         ),
  //       ],
  //     ),
  // )),
    );
  }
}
