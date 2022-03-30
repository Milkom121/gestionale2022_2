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

  int _totalCost = 1;

  List<int> get beachBundleList {
    List<int> list = [...reservationMap['beach_bundle']];
    return list;
  }

  void addBeachBundle(int beacBundleNumber) {
    if (beachBundleList.contains(beacBundleNumber + 1) == false) {
      reservationMap['beach_bundle'].add(beacBundleNumber + 1);
    }
    notifyListeners();
  }



  List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  void addValueToReservation(String key, dynamic value) {
    reservationMap[key] = value;
    notifyListeners();
  }

  String returnDayName() {
    String reservationDay = DateFormat('EEEE').format(DateTime.parse(reservationMap['date']));
    return reservationDay;

  }

  void calculateTotalCost() {
    _totalCost += (int.parse(reservationMap['beach_chair']) * beachChairPrice);
    _totalCost += (beachBundleList.length) * beachBundlePrice;


    if (weekDays.contains(returnDayName)) {
      if (reservationMap['day_slot']['entire']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketWeekEntirePrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
      if (reservationMap['day_slot']['half']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketWeekHalfPrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
      if (reservationMap['day_slot']['late']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketWeekLatePrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
    }

    if (returnDayName == 'Saturday') {
      if (reservationMap['day_slot']['entire']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketSaturdayEntirePrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
      if (reservationMap['day_slot']['half']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketSaturdayHalfPrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
      if (reservationMap['day_slot']['late']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketSaturdayLatePrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
    }

    if (returnDayName == 'Sunday') {
      if (reservationMap['day_slot']['entire_day']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketSundayEntirePrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
      if (reservationMap['day_slot']['half_day']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketSundayHalfPrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
      if (reservationMap['day_slot']['late_day']) {
        _totalCost +=
            int.parse(reservationMap['tickets'] * ticketSundayLatePrice) -
                int.parse(reservationMap['discount'] * discountPrice);
      }
    }

    //addValueToReservation('total_cost', _totalCost);

    reservationMap['total_cost'] += _totalCost;

    notifyListeners();
  }
}

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
