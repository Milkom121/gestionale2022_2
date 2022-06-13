
import 'dart:convert';

class Reservation {
// Generate a v1 (time-based) id

   // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'

  //final Customer customer;
  final String date;
  final String daySlot; //entire, half, late
  final int tickets;
  final int? discount ;
  final int? beachChairs ;
  final List<int>? beachBundle ;
  final int totalCost;

  final String customerId;

  Reservation(

    {
    required  this.discount,
    required this.beachChairs,
    required this.beachBundle,
    required this.customerId,
    required this.date,
    required this.daySlot,
    required this.tickets,
    required this.totalCost,
  });

  // ///serializer
  // static Reservation mapToReservation(Map<String, dynamic> map) {
  //   //List<int> _beachBundleList = map['beach_bundle'];
  //   print(map);
  //   Reservation reservation =  Reservation(
  //
  //     discount: map['discount'],
  //     beachChairs: map['beach_chairs'],
  //     beachBundle: map['beach_bundle'], //_beachBundleList,
  //     // customer: map['customer'],
  //     date: map['date'],
  //     daySlot: map['day_slot'],
  //     tickets: map['tickets'],
  //     totalCost: map['total_cost'],
  //     customerId: map['customerId']
  //   );
  //   print (reservation);
  //   return reservation;
  //
  // }

  List<int> returnBundleList(String jsonList){
    List<int> list = json.decode(jsonList).cast<int>();
    return list;

  }

  factory Reservation.fromMap(dynamic map) {
    // List<int> list =
    // map['beachBundle']
    //
    //     .split(',')
    //     .map<int>((e) {
    //   return int.tryParse(e); //use tryParse if you are not confirm all content is int or require other handling can also apply it here
    // })
    //     .toList();
    //  for (var element in list) {
    //        list.add(element);
    //      }
     //TODO: capire perchè non va


    return Reservation(
    date: map['date'].toString(),
    daySlot: map['daySlot'], //entire, half, late
    tickets: int.parse(map['tickets']),
    discount: int.parse(map['discount']),
    beachChairs: int.parse(map['beachChairs']),
    beachBundle: json.decode(map['beachBundle']) ,
    totalCost: int.parse(map['totalCost']),
    customerId: map['customerId']
    );}


  ///serializer
  static Map<String, dynamic> reservationToMap(Reservation reservation) => {
        //'customer': reservation.customer,
        'date': reservation.date,
        'day_slot': reservation.daySlot, //entire, half, late
        'tickets': reservation.tickets,
        'discount': reservation.discount,
        'beach_chairs': reservation.beachChairs,
        'beach_bundle': reservation.beachBundle,
        'total_cost': reservation.totalCost,
      };
}
