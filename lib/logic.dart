import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';




class ReservationFormLogic extends ChangeNotifier {

  int ticketWeekEntire = 8;
  int ticketWeekHalf = 5;
  int ticketWeekLate = 3;
  int ticketSaturdayEntire = 12;
  int ticketSaturdayHalf = 8;
  int ticketSaturdayLate = 5;
  int ticketSundayEntire = 14;
  int ticketSundayHalf = 10;
  int ticketSundayLate = 6;
  int discount = 3;
  int beachChair = 3;
  int beachBundle = 9;


  Map reservationMap = {
    'id_token': '',
    'date': '',
    'tickets': 0,
    'discount': 0,
    'day_slot': 'entire', //entire, half, late
    'beach_chair': 0,
    'beach_bundle': [],
    'total_cost': 0,
  };

  int _totalCost = 0;

  List<String> weekDays = [
    'Monday',
    'Tuesday'
        'Wednesday',
    'Thursday',
    'Friday',
  ];



  String returnDayName () {
    String reservationDay = DateFormat('EEEE').format(reservationMap['date']);
    return reservationDay ;
  }

  void CalculateTotalCost() {

    if (weekDays.contains(returnDayName)) {

      if (reservationMap['day_slot']['entire_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketWeekEntire) -
            int.parse(reservationMap[discount] * discount);
      }
      if (reservationMap['day_slot']['half_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketWeekHalf) -
            int.parse(reservationMap[discount] * discount);
      }
      if (reservationMap['day_slot']['late_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketWeekLate) -
            int.parse(reservationMap[discount] * discount);
      }
    }

    if (returnDayName == 'Saturday') {

      if (reservationMap['day_slot']['entire_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketSaturdayEntire) -
            int.parse(reservationMap[discount] * discount);
      }
      if (reservationMap['day_slot']['half_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketSaturdayHalf) -
            int.parse(reservationMap[discount] *  discount);
      }
      if (reservationMap['day_slot']['late_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketSaturdayLate) -
            int.parse(reservationMap[discount] * discount);
      }
    }

    if (returnDayName == 'Sunday') {

      if (reservationMap['day_slot']['entire_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketSundayEntire) -
            int.parse(reservationMap[discount] * discount);
      }
      if (reservationMap['day_slot']['half_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketSundayHalf) -
            int.parse(reservationMap[discount] *  discount);
      }
      if (reservationMap['day_slot']['late_day']) {
        _totalCost += int.parse(reservationMap['tickets'] * ticketSundayLate) -
            int.parse(reservationMap[discount] * discount);
      }
    }


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
