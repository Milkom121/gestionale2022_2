
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/users_types.dart';
import 'package:http/http.dart' as http;

class CustomerDetailViewScreenLogic extends ChangeNotifier {

  static late Future<CustomerDB> futureCustomers;

   static CustomerDB? customerDB;

  void resolveFutureCustomerDB( String searchString) async {
    futureCustomers = fetchCustomerById(searchString);
    customerDB = await futureCustomers;

  }


  Future<CustomerDB> fetchCustomer( String searchString) async {
    final response = await http.get(Uri.parse('https://192.168.178.74:5000/api/getCustomer?value=$searchString'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<CustomerDB>((json) => CustomerDB.fromMap(json));
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }


  Future<CustomerDB> fetchCustomerById(String id) async {
    final response = await http.get(Uri.parse('https://192.168.178.74:5000/api/getCustomerById?value=$id'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      print(parsed);
      CustomerDB customerDB = parsed.map<CustomerDB>((json) => CustomerDB.fromMap(json));
      print(customerDB.id);
      return customerDB;

    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }


 // CustomerDB returnFetchedCustomerDB()


}