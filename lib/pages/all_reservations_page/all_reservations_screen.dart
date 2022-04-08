import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestionale2022_2/pages/all_reservations_page/search/search_form_widget.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_navigation_bar.dart';
import '../../models/reservation.dart';
import 'all_reservations_logic.dart';

class AllReservationsScreen extends StatefulWidget {
  static const routeName = '/AllReservationScreen';

  @override
  State<AllReservationsScreen> createState() => _AllReservationsScreenState();
}

class _AllReservationsScreenState extends State<AllReservationsScreen> {
  final int screenIndex = 2;
  bool _searchVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AllReservationLogic>(
      builder: (context, _allReservationsLogic, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _searchVisibility = !_searchVisibility;
                });
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Ecco tutte le postazioni già prenotate: ' +
                _allReservationsLogic.getAllBeachBundleReserved.toString());
          },
        ),
        bottomNavigationBar: AppNavigationBar(screenIndex),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: _searchVisibility,
                  child: SearchFormWidget(),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _allReservationsLogic.getAllReservations.length,
                    itemBuilder: (BuildContext context, int index) {
                      Reservation _reservationInstance = _allReservationsLogic
                              .getAllReservations[
                          index]; //rappresenta la singola prenotazione nella lista delle prenotazioni
                      return Card(
                        child: ListTile(
                          title: Text(_reservationInstance.date),
                          subtitle: const Text('*customer_name*'),
                          trailing: Text(
                              '€ ' + _reservationInstance.totalCost.toString()),
                        ),
                      );
                    }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // ///0000000000000000000000000000000000000000000000000000000///
// // ///CODICE SPERIMENTALE PER INVIARE DATI A DJANGO
// // ///0000000000000000000000000000000000000000000000000000000///
// // Future<List<Reservation>> getEmployeeList() async {
// //   final response = await http.get("${Env.URL_PREFIX}/employeedetails");
// //
// //   final items = json.decode(response.body).cast<Map<String, dynamic>>();
// //   List<Employee> employees = items.map<Employee>((json) {
// //     return Employee.fromJson(json);
// //   }).toList();
// //
// //   return employees;
// // }
// //
// // ///0000000000000000000000000000000000000000000000000000000///
// // ///FINE--CODICE SPERIMENTALE PER INVIARE DATI A DJANGO
// // ///0000000000000000000000000000000000000000000000000000000///
//
//
// import 'package:flutter/material.dart';
// import 'package:gestionale2022_2/models/reservation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '';
//
//
// class AllReservationsScreen extends StatefulWidget {
//
//   static String routeName = ('/AllReservationsScreen');
//
//    String URL_PREFIX = "http://192.168.178.74:8000/";
//
//   @override
//   AllReservationsScreenState createState() => AllReservationsScreenState();
// }
//
// class AllReservationsScreenState extends State<AllReservationsScreen> {
//
//
//
//   late Future<List<Reservation>> reservations ;
//
//   final reservationsListKey = GlobalKey<AllReservationsScreenState>();
//
//   @override
//   void initState() {
//     super.initState();
//     reservations = getEmployeeList();
//   }
//
//   Future<List<Reservation>> getEmployeeList() async {
//     final response = await http.get(Uri.parse("${ widget.URL_PREFIX}"));
//
//     final items = json.decode(response.body).cast<Map<String, dynamic>>();
//     List<Reservation> employees = items.map<Reservation>((json) {
//       return Reservation.fromJson(json);
//     }).toList();
//
//     return employees;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: reservationsListKey,
//       appBar: AppBar(
//         title: const  Text('Employee List'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Reservation>>(
//           future: reservations,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             // By default, show a loading spinner.
//             if (!snapshot.hasData) return const CircularProgressIndicator();
//             // Render employee lists
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var data = snapshot.data[index];
//                 return Card(
//                   child: ListTile(
//                     leading: const Icon(Icons.person),
//                     title: Text(
//                       data.ename,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }}
