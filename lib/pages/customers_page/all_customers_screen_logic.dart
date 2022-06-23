///ATTUALMENMTE QUESTO FILE FUNGE DA TEST PER IL RECUPERO DEI DATI DAL BACKEND
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/users_types.dart';
import 'package:http/http.dart' as http;

class AllCustomersScreenLogic with ChangeNotifier {

  static late Future<List<CustomerDB>> futureCustomers;

   List<CustomerDB> foundCustomers = [];

   List<CustomerDB> allCustomers = [];


  Future<List<CustomerDB>> fetchCustomerDB() async {
    final response = await http.get(Uri.parse('https://192.168.178.74:5000/api/customers'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<CustomerDB>((json) => CustomerDB.fromMap(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

void convertFutureListOfCustomerDBToList() async {
    futureCustomers = fetchCustomerDB();
    allCustomers = [... await futureCustomers];

}

    //var url = Uri.https('192.168.178.74', '/api/customers', );//{'q': '{http}'}

    // Await the http get response, then decode the json-formatted response.

    // if (response.statusCode == 200) {
    //   if (response.statusCode == 200) {
    //     List<CustomerDB> fetchedCustomers = [];
    //     var jsonResponse = convert.jsonDecode(response.body) as List<Map>;
    //     for (Map element in jsonResponse) {
    //       fetchedCustomers.add(
    //         CustomerDB(
    //           id: element['idToken'],
    //           name: element['name'],
    //           surname: element['surname'],
    //           email: element['email'],
    //           phoneNumber: element['phoneNumber'],
    //         ),
    //       );
    //       print(element);
    //     }
    //     allCustomers = fetchedCustomers;
    //     print(allCustomers);
    //     notifyListeners();
    //   }
    // }
    //}


  void initialShowedCustomers() {
    foundCustomers = allCustomers;

  }

  // This function is called whenever the text field changes
  void runFilter(String enteredKeyword) {
    List<CustomerDB> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allCustomers;
    } else {
      results = allCustomers
          .where((customerDB) => customerDB.returnNameAndSurname
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    foundCustomers = results;
    notifyListeners();
  }
}




