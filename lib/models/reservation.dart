
class Reservation {



// Generate a v1 (time-based) id

   // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'

  //final Customer customer;
  final String idToken ;
  final String date;
  final String daySlot; //entire, half, late
  final int tickets;
  int discount = 0;
  int beachChair = 0;
  List beachBundle = []; //TODO: capire come fare per specificare che è una List<int> senza che dia errore
  final int totalCost;

  Reservation(
    //dati non obbligatori
    this.discount,
    this.beachChair,
    this.beachBundle,
    //dati obbligatori
    {
    //required this.customer,
    required this.idToken,
    required this.date,
    required this.daySlot,
    required this.tickets,
    required this.totalCost,
  });

  ///serializer
  static Reservation mapToReservation(Map<String, dynamic> map) {
    //List<int> _beachBundleList = map['beach_bundle'];
    print(map);
    Reservation reservation =  Reservation(
      map['discount'],
      map['beach_chairs'],
      map['beach_bundle'], //_beachBundleList,
      // customer: map['customer'],
      idToken: map['id_token'],
      date: map['date'],
      daySlot: map['day_slot'],
      tickets: map['tickets'],
      totalCost: map['total_cost'],
    );
    print (reservation.idToken);
    return reservation;

  }

  ///serializer
  static Map<String, dynamic> reservationToMap(Reservation reservation) => {
        //'customer': reservation.customer,
        'id_token': reservation.idToken,
        'date': reservation.date,
        'day_slot': reservation.daySlot, //entire, half, late
        'tickets': reservation.tickets,
        'discount': reservation.discount,
        'beach_chairs': reservation.beachChair,
        'beach_bundle': reservation.beachBundle,
        'total_cost': reservation.totalCost,
      };
}
