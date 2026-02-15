import "package:get/get.dart";
import "package:getx_demo1/model/product.dart";
class CartController extends GetxController{
  var cartItems=[].obs;

  void addToCart(Product product){
    cartItems.add(product);
  }

  void removeFromCart(Product product){
    cartItems.remove(product);
  }

  int get itemCount=>cartItems.length;

  get totalPrice => null;
}