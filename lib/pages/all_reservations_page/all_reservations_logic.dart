import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/reservation.dart';

class AllReservationLogic extends ChangeNotifier {


  static final List<Reservation> _allReservations = [
    // Reservation(1, 1, [4, 6],
    //     idToken: 'idToken',
    //     date: '2022-04-07',
    //     daySlot: 'entire',
    //     tickets: 1,
    //     totalCost: 37),
    //
    // Reservation(1, 1, [5, 7],
    //     idToken: 'idToken',
    //     date: '2022-04-07',
    //     daySlot: 'entire',
    //     tickets: 1,
    //     totalCost: 37)
  ];

  List<Reservation> get getAllReservations {
    List<Reservation> list = [..._allReservations];
    return list;
  }

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
