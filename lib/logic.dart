import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ReservationFormLogic extends ChangeNotifier {
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

  static Map reservationMap = {
    'id_token': '',
    'date': '',
    'day_slot': 'entire', //entire, half, late
    'tickets': 0,
    'discount': 0,
    'beach_chairs': 0, //TODO capire perchè non aggiunge beach chair
    'beach_bundle': [],
    'total_cost': 0,
  };

  //int _totalCost = 0;

  List<int> get getBeachBundleList {
    List<int> list = [...reservationMap['beach_bundle']];
    return list;
  }

  ///000000000000000000000000000000000000000000000000000000000///
  ///CODICE SPERIMENTALE - creerò dei getter per ogni variabile che mio occorre dalla prenotationMap///

  void set setTotalCost(int totalCost) {
    reservationMap['total_cost'] = totalCost;
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
    String value = reservationMap['day_slot'];
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
    int value = reservationMap['beach_chairs'];
    return value;
  }

  int get getTotalCost {
    int value = reservationMap['total_cost'];
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
    notifyListener();
  }

  void addBeachBundle(int beacBundleNumber) {
    if (getBeachBundleList.contains(beacBundleNumber + 1) == false) {
      reservationMap['beach_bundle'].add(beacBundleNumber + 1);
    }
    notifyListeners();
  }

  void removeBeachBundle(int beacBundleNumber) {
    if (getBeachBundleList.contains(beacBundleNumber + 1)) {
      reservationMap['beach_bundle'].remove(beacBundleNumber + 1);
    }
    notifyListeners();
  }

  void removeAllBeachBundle() {
    reservationMap['beach_bundle'].clear();
  }

  void notifyListener() {
    notifyListeners();
  }

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
