import "package:flutter/material.dart";
import "package:provider_demo1_trip_packer/models/packing_item.dart";

class PackingProvider extends ChangeNotifier{
  final List <ItemModel> _items=[];

  List<ItemModel> get items=>_items;

  void addItem(String itemName){
    if(itemName.trim().isEmpty)return;
    _items.add(ItemModel(name: itemName));
    notifyListeners();
  }

  void togglePackedStatus(int index){
    _items[index].isPacked =!_items[index].isPacked;
    notifyListeners();
  }

  void removeItem(int index){
    _items.removeAt(index);
    notifyListeners();
  }

}