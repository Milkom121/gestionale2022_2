// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:gestionale2022_2/pages/customer_detail_view/customer_detail_view_screen.dart';
// import 'package:provider/provider.dart';
//
// import '../../common_widgets/app_navigation_bar.dart';
// import '../all_reservations_page/all_reservations_logic.dart';
// import 'all_customers_screen_logic_2.dart';
//
// class AllCustomersScreen2 extends StatefulWidget {
//   static const routeName = '/AllCustomersScreen2';
//
//   @override
//   State<AllCustomersScreen2> createState() => _AllCustomersScreen2State();
// }
//
// class _AllCustomersScreen2State extends State<AllCustomersScreen2> {
//   final int screenIndex = 2;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     final _allCustomerLogicProvider =
//         Provider.of<AllCustomersLogic>(context, listen: false);
//     _allCustomerLogicProvider.initialShowedCustomers();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var _allReservationsProvider = Provider.of<AllReservationsLogic>(context);
//     return Consumer<AllCustomersLogic>(
//         builder: (context, _allCustomersLogic, child) {
//       Future.delayed(Duration.zero, () {
//         //your code goes here
//       });
//
//       return Scaffold(
//         bottomNavigationBar: AppNavigationBar(screenIndex),
//         appBar: AppBar(
//           title: const Text('Customers'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 onChanged: (value) => _allCustomersLogic.runFilter(value),
//                 decoration: const InputDecoration(
//                     labelText: 'Search', suffixIcon: Icon(Icons.search)),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: _allCustomersLogic.foundCustomers.isNotEmpty
//                     ? ListView.builder(
//                         itemCount: _allCustomersLogic.foundCustomers.length,
//                         itemBuilder: (context, index) => Card(
//                           key: ValueKey(
//                               _allCustomersLogic.foundCustomers[index].id),
//                           // color: Colors.amberAccent,
//                           elevation: 4,
//                           margin: const EdgeInsets.symmetric(vertical: 10),
//                           child: ListTile(
//                             onTap: () {
//                               _allReservationsProvider.getReservationByCustomer(
//                                   _allCustomersLogic.foundCustomers[index]);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         CustomerDetailViewScreen(
//                                             customerDB: _allCustomersLogic
//                                                 .foundCustomers[index])),
//                               );
//                             },
//                             leading: Text(
//                               (index + 1).toString(),
//                               style: const TextStyle(fontSize: 24),
//                             ),
//                             title: Text(_allCustomersLogic
//                                 .foundCustomers[index].returnNameAndSurname),
//                             subtitle: Text(
//                                 '${_allCustomersLogic.foundCustomers[index].phoneNumber.toString()} '),
//                           ),
//                         ),
//                       )
//                     : const Text(
//                         'No results found',
//                         style: TextStyle(fontSize: 24),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
//
// //Consumer<AllCustomersLogic>(
// //    builder: (context, _allCUstomersLogic, child) {
// //      return ListView();
// // });
