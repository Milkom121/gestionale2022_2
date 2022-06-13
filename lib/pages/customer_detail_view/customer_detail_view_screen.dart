//
//
// import 'package:flutter/material.dart';
// import 'package:gestionale2022_2/models/reservation.dart';
// import 'package:gestionale2022_2/models/users_types.dart';
// import 'package:gestionale2022_2/pages/all_reservations_page/all_reservations_logic.dart';
// import 'package:provider/provider.dart';
// // class CustomerDetailViewScreen extends StatelessWidget {
// //   const CustomerDetailViewScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //       ),
// //       body: ,
// //
// //     );
// //   }
// // }
//
//
// class CustomerDetailViewScreen extends StatelessWidget {
//   const CustomerDetailViewScreen({Key? key, required this.customerDB} ) : super(key: key);
//
//   final CustomerDB customerDB;
//   static const routeName = '/CustomerDetailViewScreen';
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var _allReservationsProvider = Provider.of<AllReservationsLogic>(context);
//     _allReservationsProvider.getReservationByCustomer(customerDB);
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.black),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         actions: [
//           IconButton(
//             icon: const  Icon(Icons.close),
//             color: Colors.black,
//             onPressed: (){
//
//               Navigator.pop(context);
//               //inviare posizione gps ad amici
//             }
//             ,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//
//
//                   Center(
//                     child: Column(
//                       children: [
//
//                         Text(customerDB.returnNameAndSurname,
//                           style: const TextStyle(
//                             fontSize: 23,
//                             fontWeight: FontWeight.bold,
//                           ),)
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 30,),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text('Email',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold
//                               ),),
//                             const SizedBox(height: 10,),
//                             Text(customerDB.email),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text('Phone Number',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold
//                               ),),
//                             const SizedBox(height: 10,),
//                             Text(customerDB.phoneNumber),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 15,),
//
//
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: AllReservationsLogic.allFoundReservationsList.length,
//                     itemBuilder: (context, index) {
//                             //_allReservationsProvider.getReservationByCustomer(customerDB);
//                             Reservation _currentReservation = AllReservationsLogic.allFoundReservationsList[index];
//                             return Card(
//                               // key: ValueKey(
//                               //     _allReservationsProvider.getAllFoundReservations[index].id),
//                               // color: Colors.amberAccent,
//                               elevation: 4,
//                               margin: const EdgeInsets.symmetric(vertical: 10),
//                               child: ListTile(
//                                 title: Text(_currentReservation.date),
//                                 subtitle: Text(_currentReservation.customerId.returnNameAndSurname),
//                                 trailing: Text('€ ' +
//                                     _currentReservation.totalCost.toString()),
//                               ),
//                             );
//                           })
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
