// Service Provider Model Methods

import 'package:registerpage/model/funct_model/model_serviceprovider.dart';
import 'package:sqflite/sqflite.dart';

dynamic database;

void insertServiceProviderData(ServiceProviderModel cobj) async {
  Database customerDB = await database;

  customerDB.insert("ServiceProviderInfo", cobj.serviceProviderModelMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> getServiceProviderData() async {
  Database customerDB = database;
  List<Map<String, dynamic>> customerModelMap =
      await customerDB.query("ServiceProviderInfo");

  return customerModelMap;
}

updateServiceProviderData(ServiceProviderModel customerObj) async {
  Database customerDB = database;

  customerDB.update(
    "ServiceProviderInfo",
    customerObj.serviceProviderModelMap(),
    where: "mobNo=?",
    whereArgs: [customerObj.mobNo],
  );
}

void deleteServiceProviderData(int mobNo) async {
  Database customerDB = database;
  customerDB.delete("ServiceProviderInfo", where: "mobNo = ?", whereArgs: [mobNo]);
}