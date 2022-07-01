
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/reservation.dart';
import 'package:http/http.dart' as http;

import '../models/users_types.dart';

class DAO extends ChangeNotifier{

  final String _addressDB = 'https://192.168.178.74:5000/';


   Future<List<Reservation>> fetchAllReservations() async {
    final response = await http.get(Uri.parse(_addressDB + 'api/reservations'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Reservation>((json) => Reservation.fromMap(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

  Future<List<Reservation>> findReservations(String field, String value) async {
    final response = await http.get(Uri.parse('$_addressDB api/getReservation?field=$field&value=$value'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Reservation>((json) => Reservation.fromMap(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

  Future<List<Reservation>> addNewReservation(Map reservationMap) async {

    String customerId = reservationMap['customerId'].toString();
    String date = reservationMap['date'];
    String daySlot = reservationMap['daySlot'];
    String tickets = reservationMap['tickets'].toString();
    String discount = reservationMap['discount'].toString();
    String beachChairs = reservationMap['beachChairs'].toString();
    String  beachBundleList = reservationMap['beachBundle'].toString();
    String beachBundle = beachBundleList.replaceAll('[', '').replaceAll(']', '');
    String totalCost = reservationMap['totalCost'].toString();


    final response = await http.get(Uri.parse('$_addressDB/api/newReservation?customerId=$customerId&discount=$discount&beachChairs=$beachChairs&beachBundle=$beachBundle&date=$date&daySlot=$daySlot&tickets=$tickets&totalCost=$totalCost'));//TODO: modificare per creare una nuova reservation
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Reservation>((json) => Reservation.fromMap(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

  ///=========================CUSTOMERS DAO=======================================

  Future<List<CustomerDB>> fetchAllCustomerDB() async {
    final response = await http.get(Uri.parse('$_addressDB/api/customers'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<CustomerDB>((json) => CustomerDB.fromMap(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

///======================metodo di test per recuperare un CustoemrDB========================
  Future<CustomerDB> findCustomerDB(String field, String value) async {
    final response = await http.get(Uri.parse('$_addressDB api/getCustomer?field=$field&value=$value'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<CustomerDB>((json) => CustomerDB.fromMap(json));
    } else {
      print(response.statusCode);
      throw Exception('Failed to load customers');
    }
  }

}

