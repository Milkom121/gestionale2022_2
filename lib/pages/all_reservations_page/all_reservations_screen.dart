import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestionale2022_2/models/reservation.dart';
import 'package:gestionale2022_2/pages/reservation_view_page/reservation_view_screen.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_navigation_bar.dart';
import '../all_reservations_page/all_reservations_logic.dart';
import '../customers_page/all_customers_screen_logic.dart';
import '../new_reservation_page/screens/new_reservation_screen.dart';
import '../new_reservation_page/screens/reservation_customer_search.dart';

class AllReservationsScreen extends StatefulWidget {
  const AllReservationsScreen({Key? key}) : super(key: key);

  static const routeName = '/AllReservationsScreen';
  final int screenIndex = 1;

  @override
  State<AllReservationsScreen> createState() => _AllReservationsScreenState();
}

class _AllReservationsScreenState extends State<AllReservationsScreen> {
  final int screenIndex = 1;
  final TextEditingController? _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    final _allReservationsLogicProvider =
    Provider.of<AllReservationsLogic>(context, listen: false);
    final _allCustomerLogicProvider =
    Provider.of<AllCustomersScreenLogic>(context, listen: false);
    // _allCustomerLogicProvider.initialShowedCustomers();
    _allCustomerLogicProvider.convertFutureListOfCustomerDBToList();
    super.initState();

    //AllCustomersScreenLogic.futureCustomers = _allCustomerLogicProvider.fetchCustomerDB();
    _allReservationsLogicProvider.convertFutureReservationsToList();
  }

  @override
  Widget build(BuildContext context) {
    final _allCustomerLogicProvider =
    Provider.of<AllCustomersScreenLogic>(context, listen: false);

    return Consumer<AllReservationsLogic>(
        builder: (context, _allReservationsLogic, child) {
          // Future.delayed(Duration.zero, () {
          //   //your code goes here
          // });

          return Scaffold(
            key: UniqueKey(),
            bottomNavigationBar: AppNavigationBar(screenIndex),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext bc) {
                      return Wrap(children: <Widget>[
                        NewReservationScreen(
                          // onClose: () { setState(() { });},
                        )
                      ]);
                    });
                // showModalBottomSheet<void>(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return NewReservationScreen();
                //   },
                // );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  NewReservationScreen()),
                // );
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: const Text('Customers'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: UniqueKey(),
                    initialValue: _allReservationsLogic.searchingCustomerName,
                    //initialValue: '',
                    readOnly: true,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        label: const Text('Customer'),
                        suffixIcon: InkWell(
                            child: const Icon(Icons.clear, size: 14),
                            onTap: () {
                              _allReservationsLogic.setSearchingToDefault();
                            })),

                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ReservationCustomerSearch(
                                whichCaseIsThis: 'allReservations');
                          });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateTimePicker(
                      decoration: InputDecoration(
                          icon: const Icon(Icons.event),
                          label: const Text('Date'),
                          suffixIcon: InkWell(
                              child: const Icon(Icons.clear, size: 14),
                              onTap: () {
                                _allReservationsLogic.setSearchingToDefault();
                              })),
                      initialValue: _allReservationsLogic.searchingDate,
                      type: DateTimePickerType.date,
                      dateMask: 'dd MMM, yyyy',
                      // controller: _timeController,
                      //initialValue: _initialValue,
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2100),
                      onChanged: (day) {
                        _allReservationsLogic.searchByDate(day);
                        _allReservationsLogic.setSearchingDate(day);
                        print(day);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child:

                      //Todo: la ricerca funziona e quando si cancella vengono mostrat correttamente tutti i customers, però alla prima apertura risulta "not found" e non so perché
                      ///############CODICE DA SISTEMARE, ISOLARE E FATTORIZZARE############

                      (_allReservationsLogic.foundReservations.isEmpty &&
                          _allReservationsLogic.isSearching == false)
                          ?

                      //allCustomersView
                      FutureBuilder<List<Reservation>>(
                          future: AllReservationsLogic.futureReservations,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: _allReservationsLogic
                                      .allReservations.length,
                                  itemBuilder: (context, index) {
                                    final String customerCompleteName = _allCustomerLogicProvider
                                        .getCompleteCustomerNameById(
                                        _allReservationsLogic
                                            .allReservations[
                                        index]
                                            .customerId);
                                    return Card(
                                      key: ValueKey(
                                          _allReservationsLogic
                                              .allReservations[index]
                                              .customerId),
                                      // color: Colors.amberAccent,
                                      elevation: 4,
                                      margin:
                                      const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReservationViewScreen(
                                                      reservation:
                                                      _allReservationsLogic
                                                          .allReservations[
                                                      index],
                                                      customerCompleteName:
                                                      customerCompleteName),
                                            ),
                                          );
                                        },
                                        leading: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                              fontSize: 24),
                                        ),
                                        title: Text(
                                            _allReservationsLogic
                                                .allReservations[index]
                                                .date),
                                        subtitle: Text(
                                            '${_allCustomerLogicProvider
                                                .getCompleteCustomerNameById(
                                                _allReservationsLogic
                                                    .allReservations[index]
                                                    .customerId)} '),
                                        trailing: Text(
                                            '${_allReservationsLogic
                                                .allReservations[index]
                                                .totalCost.toString()} '),
                                      ),
                                    );

                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          })
                          : (_allReservationsLogic.foundReservations.isNotEmpty)
                          ?

                      //foundCustomers view
                      ListView.builder(
                          itemCount: _allReservationsLogic
                              .foundReservations.length,
                          itemBuilder: (context, index) {
                            final String customerCompleteName = _allCustomerLogicProvider
                                .getCompleteCustomerNameById(
                                _allReservationsLogic
                                    .foundReservations[
                                index]
                                    .customerId);

                            return
                              Card(
                                key: ValueKey(_allReservationsLogic
                                    .foundReservations[index]
                                    .customerId),
                                // color: Colors.amberAccent,
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReservationViewScreen(
                                                reservation:
                                                _allReservationsLogic
                                                    .foundReservations[
                                                index],
                                                customerCompleteName:
                                                customerCompleteName),
                                      ),
                                    );
                                  },
                                  leading: Text(
                                    (index + 1).toString(),
                                    style: const TextStyle(
                                        fontSize: 24),
                                  ),
                                  title: Text(_allReservationsLogic
                                      .foundReservations[index].date),
                                  subtitle: Text(customerCompleteName
                                  ),
                                ),
                              );
                          }
                      )
                          : (_allReservationsLogic
                          .foundReservations.isEmpty &&
                          _allReservationsLogic.isSearching == true)
                          ? const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      )
                          : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      )

                    ///############ FINE CODICE DA SISTEMARE, ISOLARE E FATTORIZZARE############

                  ),
                ],
              ),
            ),
          );
        });
  }
}

// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:gestionale2022_2/models/reservation.dart';
// import 'package:gestionale2022_2/network/DAO.dart';
// import 'package:provider/provider.dart';
//
// import '../../common_widgets/app_navigation_bar.dart';
// import '../all_reservations_page/all_reservations_logic.dart';
// import '../new_reservation_page/screens/new_reservation_screen.dart';
// import '../new_reservation_page/screens/reservation_customer_search.dart';
//
// class AllReservationsScreen extends StatefulWidget {
//   const AllReservationsScreen({Key? key}) : super(key: key);
//
//   static const routeName = '/AllReservationsScreen';
//   final int screenIndex = 1;
//
//   @override
//   State<AllReservationsScreen> createState() => _AllReservationsScreenState();
// }
//
// class _AllReservationsScreenState extends State<AllReservationsScreen> {
//   final int screenIndex = 1;
//   final TextEditingController? _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     final _allReservationsLogicProvider =
//         Provider.of<AllReservationsLogic>(context, listen: false);
//     // _allCustomerLogicProvider.initialShowedCustomers();
//     super.initState();
//     //AllCustomersScreenLogic.futureCustomers = _allCustomerLogicProvider.fetchCustomerDB();
//     _allReservationsLogicProvider.convertFutureReservationsToList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllReservationsLogic>(
//         builder: (context, _allReservationsLogic, child) {
//       // Future.delayed(Duration.zero, () {
//       //   //your code goes here
//       // });
//
//       return Scaffold(
//         key: UniqueKey(),
//         bottomNavigationBar: AppNavigationBar(screenIndex),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             showModalBottomSheet<dynamic>(
//                 isScrollControlled: true,
//                 context: context,
//                 builder: (BuildContext bc) {
//                   return Wrap(children: <Widget>[
//                     NewReservationScreen(
//                         // onClose: () { setState(() { });},
//                         )
//                   ]);
//                 });
//             // showModalBottomSheet<void>(
//             //   context: context,
//             //   builder: (BuildContext context) {
//             //     return NewReservationScreen();
//             //   },
//             // );
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (context) =>  NewReservationScreen()),
//             // );
//           },
//           child: const Icon(Icons.add),
//         ),
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
//               TextFormField(
//                 key: UniqueKey(),
//                 initialValue: _allReservationsLogic.searchingCustomerName,
//                 //initialValue: '',
//                 readOnly: true,
//                 decoration: InputDecoration(
//                     icon: const Icon(Icons.person),
//                     label: const Text('Customer'),
//                     suffixIcon: InkWell(
//                         child: const Icon(Icons.clear, size: 14),
//                         onTap: () {
//                           _allReservationsLogic.setSearchingCustomerNameToDefault();
//                         })),
//
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return const ReservationCustomerSearch(
//                             whichCaseIsThis: 'allReservations');
//                       });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               DateTimePicker(
//                   //initialValue: DateTime.now().toString() ,
//                   type: DateTimePickerType.date,
//                   dateMask: 'dd MMM, yyyy',
//                   // controller: _timeController,
//                   //initialValue: _initialValue,
//                   firstDate: DateTime(2018),
//                   lastDate: DateTime(2100),
//                   icon: const Icon(Icons.event),
//                   dateLabelText: 'Date',
//                   onChanged: (day) {
//                     //TODO:implementare la ricerca per data
//                     print(day);
//                   }),
//               Expanded(
//                   child:
//
//                       //Todo: la ricerca funziona e quando si cancella vengono mostrat correttamente tutti i customers, però alla prima apertura risulta "not found" e non so perché
//                       ///############CODICE DA SISTEMARE, ISOLARE E FATTORIZZARE############
//
//                       (_allReservationsLogic.foundReservations.isEmpty &&
//                               _searchController != null)
//                           ?
//
//                           //allCustomersView
//                           FutureBuilder<List<Reservation>>(
//                               future: AllReservationsLogic.futureReservations,
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   return ListView.builder(
//                                     itemCount: _allReservationsLogic
//                                         .allReservations.length,
//                                     itemBuilder: (context, index) => Card(
//                                       key: ValueKey(_allReservationsLogic
//                                           .allReservations[index].customerId),
//                                       // color: Colors.amberAccent,
//                                       elevation: 4,
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 10),
//                                       child: ListTile(
//                                         onTap: () {
//                                           // _allReservationsLogic
//                                           //     .getReservationByCustomer(
//                                           //     _allCustomersLogic
//                                           //         .allCustomers[index]);
//                                           // Navigator.push(
//                                           //   context,
//                                           //   MaterialPageRoute(
//                                           //       builder: (context) =>
//                                           //           CustomerDetailViewScreen(
//                                           //               customerDB: _allCustomersLogic
//                                           //                   .allCustomers[index])),
//                                           // );
//                                         },
//                                         leading: Text(
//                                           (index + 1).toString(),
//                                           style: const TextStyle(fontSize: 24),
//                                         ),
//                                         title: Text(_allReservationsLogic
//                                             .allReservations[index].date),
//                                         subtitle: Text(
//                                             '${_allReservationsLogic.allReservations[index].totalCost.toString()} '),
//                                         trailing: Text(
//                                             '${_allReservationsLogic.allReservations[index].totalCost.toString()} '),
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   return const Center(
//                                       child: CircularProgressIndicator());
//                                 }
//                               })
//                           : (_allReservationsLogic.foundReservations.isNotEmpty)
//                               ?
//
//                               //foundCustomers view
//                               ListView.builder(
//                                   itemCount: _allReservationsLogic
//                                       .foundReservations.length,
//                                   itemBuilder: (context, index) => Card(
//                                     key: ValueKey(_allReservationsLogic
//                                         .foundReservations[index].customerId),
//                                     // color: Colors.amberAccent,
//                                     elevation: 4,
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     child: ListTile(
//                                       onTap: () {
//                                         // _allReservationsLogic.getReservationByCustomer(
//                                         //     _allCustomersLogic.foundCustomers[index]);
//                                         // Navigator.push(
//                                         //   context,
//                                         //   MaterialPageRoute(
//                                         //       builder: (context) =>
//                                         //           CustomerDetailViewScreen(
//                                         //               customerDB: _allCustomersLogic
//                                         //                   .foundCustomers[index])),
//                                         // );
//                                       },
//                                       leading: Text(
//                                         (index + 1).toString(),
//                                         style: const TextStyle(fontSize: 24),
//                                       ),
//                                       title: Text(_allReservationsLogic
//                                           .foundReservations[index].date),
//                                       subtitle: Text(
//                                           '${_allReservationsLogic.foundReservations[index].totalCost.toString()} '),
//                                     ),
//                                   ),
//                                 )
//                               : const Text(
//                                   'No results found',
//                                   style: TextStyle(fontSize: 24),
//                                 )
//
//                   ///############ FINE CODICE DA SISTEMARE, ISOLARE E FATTORIZZARE############
//
//                   ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
