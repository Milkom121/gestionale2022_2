import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/users_types.dart';

class AllCustomersLogic with ChangeNotifier {

  // List<CustomerDB> _allCustomers = [];
  // List<CustomerDB> _foundCustomers = [];
  //
  // void addNewCustomer (CustomerDB customerDB){
  //   _allCustomers.add(customerDB);
  // }
  //
  // void findCustomer( String searchString) {
  //
  // }
// This list holds the data for the list view


  List<CustomerDB> foundCustomers = [];

  final List<CustomerDB> allCustomers = [

    CustomerDB(id: '2324', name: 'MARCO', surname: 'ROSSI', email: 'marcorossi@mario.it', phoneNumber: '987546132'),
    CustomerDB(id: '2324', name: 'LUCA', surname: 'BIANCHI', email: 'lucabianchi@mario.it', phoneNumber: '879465132'),
    CustomerDB(id: '2324', name: 'Laura', surname: 'Neri', email: 'lauraneri@mario.it', phoneNumber: '4561235487'),
  ];


  void initialShowedCustomers (){
    foundCustomers = allCustomers;
    //notifyListeners();
  }



  // This function is called whenever the text field changes
  void runFilter(String enteredKeyword) {
    List<CustomerDB> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allCustomers;
    } else {
      results = allCustomers
          .where((customerDB) =>
          customerDB.returnNameAndSurname.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
      foundCustomers = results;
    notifyListeners();
  }

}

// import 'package:flutter/cupertino.dart';
// import 'package:gestionale2022_2/models/users_types.dart';
//
// class AllCustomersLogic with ChangeNotifier {
//
//   // List<CustomerDB> _allCustomers = [];
//   // List<CustomerDB> _foundCustomers = [];
//   //
//   // void addNewCustomer (CustomerDB customerDB){
//   //   _allCustomers.add(customerDB);
//   // }
//   //
//   // void findCustomer( String searchString) {
//   //
//   // }
// // This list holds the data for the list view
//
//
//   List<Map<String, dynamic>> foundCustomers = [];
//
//   final List<Map<String, dynamic>> allCustomers = [
//     {"id": 1, "name": "Andy", "age": 29},
//     {"id": 2, "name": "Aragon", "age": 40},
//     {"id": 3, "name": "Bob", "age": 5},
//     {"id": 4, "name": "Barbara", "age": 35},
//     {"id": 5, "name": "Candy", "age": 21},
//     {"id": 6, "name": "Colin", "age": 55},
//     {"id": 7, "name": "Audra", "age": 30},
//     {"id": 8, "name": "Banana", "age": 14},
//     {"id": 9, "name": "Caversky", "age": 100},
//     {"id": 10, "name": "Becky", "age": 32},
//   ];
//
//
//   void initialShowedCustomers (){
//     foundCustomers = allCustomers;
//     //notifyListeners();
//   }
//
//
//
//   // This function is called whenever the text field changes
//   void runFilter(String enteredKeyword) {
//     List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = allCustomers;
//     } else {
//       results = allCustomers
//           .where((user) =>
//           user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }
//       foundCustomers = results;
//     notifyListeners();
//   }
//
// }