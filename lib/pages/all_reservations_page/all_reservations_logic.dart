///ATTUALMENMTE QUESTO FILE FUNGE DA TEST PER IL RECUPERO DEI DATI DAL BACKEND
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/reservation.dart';
import 'package:http/http.dart' as http;

class AllReservationsLogic with ChangeNotifier {

  static late Future<List<Reservation>> futureReservations;

  List<Reservation> foundReservations = [];

  List<Reservation> allReservations = [];

///TODO: creare il file utils.dart in network per gestire le connessioni al backend
  Future<List<Reservation>> fetchReservations() async {
    final response = await http.get(Uri.parse('https://192.168.178.74:5000/api/reservations'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Reservation>((json) => Reservation.fromMap(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

  void convertFutureReservationsToList() async {
    futureReservations = fetchReservations();
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


  void initialShowedCustomers() {
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
  void runFilter(String enteredKeyword) {
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
