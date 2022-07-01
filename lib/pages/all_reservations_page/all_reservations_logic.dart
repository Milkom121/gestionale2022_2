///ATTUALMENMTE QUESTO FILE FUNGE DA TEST PER IL RECUPERO DEI DATI DAL BACKEND
import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/reservation.dart';
import 'package:gestionale2022_2/models/users_types.dart';
import 'package:gestionale2022_2/network/DAO.dart';
import 'package:gestionale2022_2/pages/customers_page/all_customers_screen_logic_2.dart';

class AllReservationsLogic with ChangeNotifier {


  static late Future<List<Reservation>> futureReservations;

  final DAO _dao = DAO();
  final AllCustomersLogic _allCustomersLogic = AllCustomersLogic();

  String searchingCustomerName= '';
  String searchingDate = '';

  bool isSearching = false;

  List<Reservation> foundReservations = [];

  List<Reservation> allReservations = [];

///TODO: creare il file utils.dart in network per gestire le connessioni al backend
//   Future<List<Reservation>> fetchReservations() async {
//     final response = await http.get(Uri.parse('https://192.168.178.74:5000/api/reservations'));
//     if (response.statusCode == 200) {
//       final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//       return parsed.map<Reservation>((json) => Reservation.fromMap(json)).toList();
//     } else {
//       print(response.statusCode);
//       throw Exception('Failed to load customers');
//     }
//   }

  // Future<String> getReservationCustomerNameById (String id)   async {
  //   //TODO: capire per quale astrocazzo di motivo questo metodo restituisce 404 ma lo stesso url su Postman funziona
  //   CustomerDB customerDB =  await _dao.getCustomerById(id);
  //   String completeCustomerName = customerDB.name + ' ' + customerDB.surname;
  //   return completeCustomerName ;
  // }



   void setSearchingCustomerName (String name){
    searchingCustomerName = name;
    notifyListeners();
  }

  void setSearchingDate (String date){
    searchingDate = date;
    notifyListeners();
  }

  void setSearchingToDefault(){
     searchingCustomerName = '';
     searchingDate = '';
     foundReservations = [];
     isSearching = false;
     notifyListeners();
  }

  void convertFutureReservationsToList() async {
    futureReservations = _dao.fetchAllReservations();
    allReservations = [... await futureReservations];

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


  void initialShowedReservations() {
    foundReservations = allReservations;

  }


  // void addNewReservation(Reservation reservation) {
  //   allReservations.add(reservation);
  //   // print("Numero prenotazioni attualmente presenti: " +
  //   //     getAllReservations.length.toString());
  //   // print('Data dell\'ultima prenotazione: ' +
  //   //     getAllReservations[getAllReservations.length - 1].date);
  //   // print('Sono state prenotati le seguenti postazioni: ' +
  //   //     getAllBeachBundleReserved.toString());
  //
  //   notifyListeners();
  // }


  // This function is called whenever the text field changes
  void searchById(String enteredKeyword) {
    List<Reservation> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allReservations;

    } else {
      results = allReservations
          .where((reservation) => reservation.customerId
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    isSearching = true;
    foundReservations = results;
    notifyListeners();
  }

  void searchByDate(String enteredKeyword){
    List<Reservation> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allReservations;
    } else {
      results = allReservations
          .where((reservation) => reservation.date
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    isSearching = true;
    foundReservations = results;
    notifyListeners();
  }


  List<Reservation> get getAllReservations {
    List<Reservation> list = [...allReservations];
    list.sort((reservation1Date, reservation2Date) {
      //sorting in ascending order
      return DateTime.parse(reservation1Date.date)
          .compareTo(DateTime.parse(reservation2Date.date));
    });
    return list;
  }

  List<int> get getAllBeachBundleReserved {
    List<int> list = [];
    for (Reservation _reservation in getAllReservations) {
      if (_reservation.beachBundle != null) {
        for (int _beachBundleNumber in _reservation.beachBundle!) { /// Posso aggiungere un ! poichè miu sono assicurato che il valore sia sempre diverso da nullo quanod viene guardato
          list.add(_beachBundleNumber);
        }
      }
    }
    // notifyListeners();
    print(list);
    return list;
  }


}





// import 'package:flutter/cupertino.dart';
// import 'package:gestionale2022_2/models/users_types.dart';
//
// import '../../models/reservation.dart';
// class AllReservationsLogic extends ChangeNotifier {
//   static final List<Reservation> _allReservations = [
//
//   ];
//
//   List<Reservation> get getAllReservations {
//     List<Reservation> list = [..._allReservations];
//     list.sort((reservation1Date, reservation2Date) {
//       //sorting in ascending order
//       return DateTime.parse(reservation1Date.date)
//           .compareTo(DateTime.parse(reservation2Date.date));
//     });
//     return list;
//   }
//
//   ///******************************************************///
//   ///CODICE PER LE FUNZIONI DI RICERCA///
//
//   ///questa sarà la lista dove verranno aggiunte le Reservation trovate dalla ricerca
//   static List<Reservation> allFoundReservationsList = [];
//
//   //questo getter fa si che se allFoundReservationsList è vuoto sia restituita ua lista con tutte le prenotazioni di _allReservations, altrimenti la lista allFoundReservationsList
//   List<Reservation> get getAllFoundReservations {
//     List<Reservation> list = [];
//     if (allFoundReservationsList.isEmpty) {
//       list = [...getAllReservations];
//     } else {
//       list = [...allFoundReservationsList];
//     }
//     return list;
//   }
//
//   Future<void> clearAllFoundReservationsList() async {
//     allFoundReservationsList = [];
//     notifyListeners();
//   }
//
//   void getReservationByDate(String date) {
//     List<Reservation> list = [];
//     for (Reservation reservation in getAllReservations) {
//       if (reservation.date == date) {
//         list.add(reservation);
//         print(reservation.date);
//       }
//     }
//
//     allFoundReservationsList=[];
//     allFoundReservationsList = [...list];
//     notifyListeners();
//   }
//
//   void getReservationByCustomer(CustomerDB customer) {
//     List<Reservation> list = [];
//     for (Reservation reservation in getAllReservations) {
//       if (reservation.customer.returnNameAndSurname == customer.returnNameAndSurname) {
//         list.add(reservation);
//       }
//     }
//     if(list.isEmpty){
//       allFoundReservationsList = [];
//       return;
//     }
//     allFoundReservationsList = [];
//     allFoundReservationsList = [...list];
//
//     notifyListeners();
//   }

//   ///fine codice per la ricerca
//   ///**************************************
//
//   List<int> get getAllBeachBundleReserved {
//     List<int> list = [];
//     for (Reservation _reservation in getAllReservations) {
//       if (_reservation.beachBundle != null) {
//         for (int _beachBundleNumber in _reservation.beachBundle!) { /// Posso aggiungere un ! poichè miu sono assicurato che il valore sia sempre diverso da nullo quanod viene guardato
//           list.add(_beachBundleNumber);
//         }
//       }
//     }
//     // notifyListeners();
//     print(list);
//     return list;
//   }
//
//   //List<int> get getAllBeachBundleReserved {
//   //   List<int> list = [];
//   //   for (Reservation _reservation in getAllReservations) {
//   //     for (int _beachBundleNumber in _reservation.beachBundle) {
//   //       list.add(_beachBundleNumber);
//   //     }
//   //   }
//   //   // notifyListeners();
//   //   print(list);
//   //   return list;
//   // }
//
//   void addNewReservation(Reservation reservation) {
//     _allReservations.add(reservation);
//     print("Numero prenotazioni attualmente presenti: " +
//         getAllReservations.length.toString());
//     print('Data dell\'ultima prenotazione: ' +
//         getAllReservations[getAllReservations.length - 1].date);
//     print('Sono state prenotati le seguenti postazioni: ' +
//         getAllBeachBundleReserved.toString());
//
//     notifyListeners();
//   }
// }
