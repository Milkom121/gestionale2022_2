import 'package:flutter/cupertino.dart';

import '../../models/reservation.dart';


class AllReservationsLogic extends ChangeNotifier {


  static final List<Reservation> _allReservations = [
    Reservation(1, 1, [4, 6],
        idToken: 'idToken',
        date: '2022-04-07',
        daySlot: 'entire',
        tickets: 1,
        totalCost: 37),

    Reservation(1, 1, [5, 7],
        idToken: 'idToken',
        date: '2022-04-07',
        daySlot: 'entire',
        tickets: 1,
        totalCost: 37),

  ];



  List<Reservation> get getAllReservations {
    List<Reservation> list = [..._allReservations];
    list.sort((reservation1Date, reservation2Date){ //sorting in ascending order
      return DateTime.parse(reservation1Date.date).compareTo(DateTime.parse(reservation2Date.date));
    });
    return list;
  }

  ///******************************************************///
  ///CODICE PER LE FUNZIONI DI RICERCA///

  ///questa sarà la lista dove verranno aggiunte le Reservation trovate dalla ricerca
  static List<Reservation> allFoundReservationsList = [];

  //questo getter fa si che se allFoundReservationsList è vuoto sia restituita ua lista con tutte le prenotazioni di _allReservations, altrimenti la lista allFoundReservationsList
  List<Reservation> get getAllFoundReservations {
    List<Reservation> list = [];
    if(allFoundReservationsList.isEmpty){
      list = [...getAllReservations];
    } else {
      list = [... allFoundReservationsList];
    }
    return list;
  }


  void clearAllFoundReservationsList (){
    allFoundReservationsList.clear();
    notifyListeners();
  }

  void  getReservationByDate (String date) {
    List<Reservation> list = [];
    for(Reservation reservation in getAllReservations){
      if(reservation.date == date){
        list.add(reservation);
        print(reservation.date);
      }

    }
    notifyListeners();
    allFoundReservationsList =  [... list];

  }

  ///fine codice per la ricerca
  ///**************************************

  List get getAllBeachBundleReserved {
    //TODO: capire come fare per specificare che è una List<int> senza che dia errore
    List list = []; //TODO: capire come fare per specificare che è una List<int> senza che dia errore
    for (Reservation _reservation in getAllReservations) {
      for (int _beachBundleNumber in _reservation.beachBundle){
        list.add(_beachBundleNumber);
      }
    }
   // notifyListeners();
    print(list);
    return list;
  }

  void addNewReservation(Reservation reservation) {
    _allReservations.add(reservation);
    print("Numero prenotazioni attualmente presenti: " + getAllReservations.length.toString());
    print( 'Data dell\'ultima prenotazione: ' + getAllReservations[getAllReservations.length-1].date);
    print('Sono state prenotati le seguenti postazioni: ' + getAllBeachBundleReserved.toString());

    notifyListeners();
  }
}
