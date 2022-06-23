import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/reservation.dart';

class NewReservationFormLogic extends ChangeNotifier {

  int ticketWeekEntirePrice = 8;
  int ticketWeekHalfPrice = 5;
  int ticketWeekLatePrice = 3;

  int ticketSaturdayEntirePrice = 12;
  int ticketSaturdayHalfPrice = 8;
  int ticketSaturdayLatePrice = 5;

  int ticketSundayEntirePrice = 14;
  int ticketSundayHalfPrice = 10;
  int ticketSundayLatePrice = 6;

  int discountPrice = 3;

  int beachChairPrice = 3;
  int beachBundlePrice = 9;

  String? reservationCustomerNameAndSurname ;
  void setReservationCustomerNameAndSurname(String returnNameAndSurname) {
    reservationCustomerNameAndSurname = returnNameAndSurname;
    notifyListeners();
  }
  void restoreReservationCustomerNameAndSurname (){
    reservationCustomerNameAndSurname = null;
    notifyListeners();
  }



  static Map<String, dynamic> reservationMap = {
    'customerId' : '', //TODO: capire cosa mettere come customerId
    'date': '',
    'daySlot': 'entire', //entire, half, late
    'tickets': 0,
    'discount': 0,
    'beachChairs': 0,
    'beachBundle': List<int>.empty(growable: true), // guardare minuto 22 di lezione con Michele del giorno 27/04/22
    'totalCost': 0,
  };

  Future<List<Reservation>> addNewReservation() async {
    //TODO: aggiungere le variabili per prendere i dati della nuova prenotazione e costruire l'url corretto

    String customerId = reservationMap['customerid'].toString();
    String date = reservationMap['date'];
    String daySlot = reservationMap['daySlot'];
    String tickets = reservationMap['tickets'].toString();
    String discount = reservationMap['discount'].toString();
    String beachChairs = reservationMap['beachChairs'].toString();
    String  beachBundleList = reservationMap['beachBundle'].toString();//TODO: occorre trovare il modo di eliminare le [] dai beach bundle (es: '[4,5,6]'-> '4,5,6')
    String beachBundle = beachBundleList.replaceAll('[', '').replaceAll(']', '');
    String totalCost = reservationMap['totalCost'].toString();


    final response = await http.get(Uri.parse('https://192.168.178.74:5000/api/newReservation?customerId=$customerId&discount=$discount&beachChairs=$beachChairs&beachBundle=$beachBundle&date=$date&daySlot=$daySlot&tickets=$tickets&totalCost=$totalCost'));//TODO: modificare per creare una nuova reservation
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Reservation>((json) => Reservation.fromMap(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

  void  restoreReservationMap() {
    reservationMap = {
      'idToken': '',
      'date': '',
      'daySlot': 'entire', //entire, half, late
      'tickets': 0,
      'discount': 0,
      'beachChairs': 0,
      'beachBundle': List<int>.empty(growable: true),
      'totalCost': 0,
    };
    notifyListeners();
  }

  //int _totalCost = 0;

  List<int> get getBeachBundleList {
    List<int> list = [...reservationMap['beachBundle']];
    return list;
  }

  ///000000000000000000000000000000000000000000000000000000000///
  ///CODICE SPERIMENTALE - creerò dei getter per ogni variabile che mio occorre dalla prenotationMap///

  set setTotalCost(int totalCost) {
    reservationMap['totalCost'] = totalCost;
  }

  void setDiscountToZero(){
    reservationMap['discount'] = 0;
  }

  String get returnDayName {
    String reservationDay =
        DateFormat('EEEE').format(DateTime.parse(reservationMap['date']));
    return reservationDay;
  }

  String get getDaySlot {
    String value = reservationMap['daySlot'];
    return value;
  }

  int get getTickets {
    int value = reservationMap['tickets'];
    return value;
  }

  int get getDiscount {
    int value = reservationMap['discount'];
    return value;
  }

  int get getBeachChairs {
    int value = reservationMap['beachChairs'];
    return value;
  }

  int get getTotalCost {
    int value = reservationMap['totalCost'];
    return value;
  }

  ///000000000000000000000000000000000000000000000000000000000///
  ///
  ///
  List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];



  void calculateTotalCost() {
    int _total = 0;

    _total += (getBeachChairs * beachChairPrice) +
        (getBeachBundleList.length * beachBundlePrice);

    //WEEK
    if (weekDays.contains(returnDayName)) {
      if (getDaySlot == 'entire') {
        _total += ((getTickets * ticketWeekEntirePrice) -
            (getDiscount * discountPrice));
      }

      if (getDaySlot == 'half') {
        _total += ((getTickets * ticketWeekHalfPrice) -
            (getDiscount * discountPrice));
      }

      if (getDaySlot == 'late') {
        _total += ((getTickets * ticketWeekLatePrice) -
            (getDiscount * discountPrice));
      }
      //SATURDAY
    } else if (returnDayName == 'Saturday') {

      if (getDaySlot == 'entire') {
        _total += ((getTickets * ticketSaturdayEntirePrice) -
            (getDiscount * discountPrice));
      }

      if (getDaySlot == 'half') {
        _total += ((getTickets * ticketSaturdayHalfPrice) -
            (getDiscount * discountPrice));
      }

      if (getDaySlot == 'late') {
        _total += ((getTickets * ticketSaturdayLatePrice) -
            (getDiscount * discountPrice));
      }
      //SUNDAY
    } else if(returnDayName == 'Sunday'){
      if (getDaySlot == 'entire') {
        _total += ((getTickets * ticketSundayEntirePrice) -
            (getDiscount * discountPrice));
      }

      if (getDaySlot == 'half') {
        _total += ((getTickets * ticketSundayHalfPrice) -
            (getDiscount * discountPrice));
      }

      if (getDaySlot == 'late') {
        _total += ((getTickets * ticketSundayLatePrice) -
            (getDiscount * discountPrice));
      }

    }
    setTotalCost = _total;
    notifyListeners();
  }

  void addBeachBundle(int beacBundleNumber) {
    if (getBeachBundleList.contains(beacBundleNumber + 1) == false) {
      reservationMap['beachBundle'].add(beacBundleNumber + 1);
    }
    notifyListeners();
  }

  void removeBeachBundle(int beacBundleNumber) {
    if (getBeachBundleList.contains(beacBundleNumber + 1)) {
      reservationMap['beachBundle'].remove(beacBundleNumber + 1);
    }
    notifyListeners();
  }

  void removeAllBeachBundle() {
    reservationMap['beachBundle'].clear();
  }

  // void notifyListener() {
  //   notifyListeners();
  // }

  void addValueToReservation(String key, dynamic value) {
    reservationMap[key] = value;
    notifyListeners();
  }



}

//CODICE NON FUNZIONANTE//
//   void calculateTotalCost() {
//     _totalCost += (int.parse(reservationMap['beach_chair']) * beachChairPrice);
//     _totalCost += (beachBundleList.length) * beachBundlePrice;
//
//     String day = returnDayName();
//
//     if (weekDays.contains(day)) {
//       if (reservationMap['day_slot'] == 'entire') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketWeekEntirePrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//       if (reservationMap['day_slot']=='half') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketWeekHalfPrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//       if (reservationMap['day_slot'] == 'late') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketWeekLatePrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//     }
//
//     if (day == 'Saturday') {
//       if (reservationMap['day_slot'] == 'entire') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketSaturdayEntirePrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//       if (reservationMap['day_slot'] == 'half') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketSaturdayHalfPrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//       if (reservationMap['day_slot'] == 'late') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketSaturdayLatePrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//     }
//
//     if (day == 'Sunday') {
//       if (reservationMap['day_slot'] == 'entire') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketSundayEntirePrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//       if (reservationMap['day_slot'] == 'half') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketSundayHalfPrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//       if (reservationMap['day_slot'] == 'late') {
//         _totalCost +=
//             int.parse(reservationMap['tickets'] * ticketSundayLatePrice) -
//                 int.parse(reservationMap['discount'] * discountPrice);
//       }
//     }
//
//     //addValueToReservation('total_cost', _totalCost);
//
//     setTotalCost = _totalCost;
//
//     print(_totalCost);
//     print(getTotalCost);
//
//     notifyListeners();
//   }
// }

// class ReservationFormLogic {
//   void CalculateTotalCost(String price, String item) {
//
//     if (reservationMap['week_slot'][0]['week'] &&
//         reservationMap['day_slot'][0]['entire_day']) {
//       _totalCost +=
//           (int.parse(reservationMap['tickets'] * ['ticket_week_entire'])) -
//               int.parse((reservationMap['discount'] * prices['discount']));
//     }
//
//     if (reservationMap['week_slot'][0]['week'] &&
//         reservationMap['day_slot'][0]['half_day']) {
//       _totalCost +=
//           (int.parse(reservationMap['tickets'] * ['ticket_week_half'])) -
//               int.parse((reservationMap['discount'] * prices['discount']));
//     }
//
//     if (reservationMap['week_slot'][0]['week'] &&
//         reservationMap['day_slot'][0]['late_day']) {
//       _totalCost +=
//           (int.parse(reservationMap['tickets'] * ['ticket_week_late'])) -
//               int.parse((reservationMap['discount'] * prices['discount']));
//     }
//
//
//     if (reservationMap['week_slot'][0]['saturday'] &&
//         reservationMap['day_slot'][0]['entire_day']) {
//       _totalCost +=
//           (int.parse(reservationMap['tickets'] * ['ticket_saturday_entire'])) -
//               int.parse((reservationMap['discount'] * prices['discount']));
//     }
//
//   }
// }
