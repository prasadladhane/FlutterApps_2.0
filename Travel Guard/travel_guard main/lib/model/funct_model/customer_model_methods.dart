// Customer Model Methods


import 'package:registerpage/model/funct_model/customer_model.dart';
import 'package:sqflite/sqflite.dart';

dynamic database;

void insertCustomerData(CustomerModel cobj) async {
  Database customerDB = await database;

  customerDB.insert("CustomerInfo", cobj.customerModelMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> getCustomerData() async {
  Database customerDB = database;
  List<Map<String, dynamic>> customerModelMap =
      await customerDB.query("customerInfo");

  return customerModelMap;
}

updateCustomerData(CustomerModel customerObj) async {
  Database customerDB = database;

  customerDB.update(
    "customerInfo",
    customerObj.customerModelMap(),
    where: "mobNo=?",
    whereArgs: [customerObj.mobNo],
  );
}

void deleteCustomerData(int mobNo) async {
  Database customerDB = database;
  customerDB.delete("customerInfo", where: "mobNo = ?", whereArgs: [mobNo]);
}