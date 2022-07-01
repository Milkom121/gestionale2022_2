///ATTUALMENMTE QUESTO FILE FUNGE DA TEST PER IL RECUPERO DEI DATI DAL BACKEND
import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/users_types.dart';
import 'package:gestionale2022_2/network/DAO.dart';

class AllCustomersScreenLogic with ChangeNotifier {

  final DAO _dao =DAO();

  static late Future<List<CustomerDB>> futureCustomers;

   List<CustomerDB> foundCustomers = [];

   List<CustomerDB> allCustomers = [];



void convertFutureListOfCustomerDBToList() async {
    futureCustomers = _dao.fetchAllCustomerDB();
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

String getCompleteCustomerNameById(String id){
  CustomerDB _customerDB;
  for (CustomerDB customer in allCustomers){
    if (customer.id == id){
      _customerDB = customer;
      String completeCustomerName;
      completeCustomerName = _customerDB.name + ' ' + _customerDB.surname;
      return completeCustomerName;
    }

  }
  return 'nothing found';
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




