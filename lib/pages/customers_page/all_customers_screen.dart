import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestionale2022_2/pages/customers_page/all_customers_screen_logic.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_navigation_bar.dart';
import '../../models/users_types.dart';
import '../all_reservations_page/all_reservations_logic.dart';
import '../customer_detail_view/customer_detail_view_screen.dart';
import 'all_customers_screen_logic.dart';





class AllCustomersScreen extends StatefulWidget {
  static const routeName = '/AllCustomersScreen';

  @override
  State<AllCustomersScreen> createState() => _AllCustomersScreenState();
}

class _AllCustomersScreenState extends State<AllCustomersScreen> {
  final int screenIndex = 2;
  final TextEditingController? _searchController = TextEditingController();
  bool seachBool = false;

  @override
  void initState() {
    // TODO: implement initState
    final _allCustomerLogicProvider =
        Provider.of<AllCustomersScreenLogic>(context, listen: false);
    // _allCustomerLogicProvider.initialShowedCustomers();
    super.initState();
    //AllCustomersScreenLogic.futureCustomers = _allCustomerLogicProvider.fetchCustomerDB();
    _allCustomerLogicProvider.convertFutureListOfCustomerDBToList();
  }

  @override
  Widget build(BuildContext context) {
    var _allReservationsProvider = Provider.of<AllReservationsLogic>(context);
    return Consumer<AllCustomersScreenLogic>(
        builder: (context, _allCustomersLogic, child) {
      // Future.delayed(Duration.zero, () {
      //   //your code goes here
      // });

      return Scaffold(
        bottomNavigationBar: AppNavigationBar(screenIndex),
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
              TextField(
                controller: _searchController,
                onChanged: (value) => _allCustomersLogic.runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
              const SizedBox(
                height: 20,
              ),

              // Expanded(
              //   child:
              //   _allCustomersLogic.foundCustomers.isNotEmpty
              //       ? FutureBuilder<List<CustomerDB>>(
              //           future: AllCustomersScreenLogic.futureCustomers,
              //           builder: (context, snapshot) {
              //             if (snapshot.hasData) {
              //               return ListView.builder(
              //                 itemCount:
              //                     _allCustomersLogic.foundCustomers.length,
              //                 itemBuilder: (context, index) => Card(
              //                   key: ValueKey(_allCustomersLogic
              //                       .foundCustomers[index].id),
              //                   // color: Colors.amberAccent,
              //                   elevation: 4,
              //                   margin:
              //                       const EdgeInsets.symmetric(vertical: 10),
              //                   child: ListTile(
              //                     onTap: () {
              //                       Navigator.pop(context);
              //                     },
              //                     leading: Text(
              //                       (index + 1).toString(),
              //                       style: const TextStyle(fontSize: 24),
              //                     ),
              //                     title: Text(_allCustomersLogic
              //                         .foundCustomers[index]
              //                         .returnNameAndSurname),
              //                     subtitle: Text(
              //                         '${_allCustomersLogic.foundCustomers[index].phoneNumber.toString()} '),
              //                   ),
              //                 ),
              //               );
              //             } else {
              //               return const Center(
              //                   child: CircularProgressIndicator());
              //             }
              //           })
              //       : const Text(
              //           'No results found',
              //           style: TextStyle(fontSize: 24),
              //         ),
              // ),
              Expanded(
                  child:

                      //Todo: la ricerca funziona e quando si cancella vengono mostrat correttamente tutti i customers, però alla prima apertura risulta "not found" e non so perché
                      ///############CODICE DA SISTEMARE, ISOLARE E FATTORIZZARE############

                      (_allCustomersLogic.foundCustomers.isEmpty &&
                              _searchController != null)
                          ?

                          //allCustomersView
                          FutureBuilder<List<CustomerDB>>(
                              future: AllCustomersScreenLogic.futureCustomers,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount:
                                        _allCustomersLogic.allCustomers.length,
                                    itemBuilder: (context, index) => Card(
                                      key: ValueKey(_allCustomersLogic
                                          .allCustomers[index].id),
                                      // color: Colors.amberAccent,
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ListTile(
                                        onTap: () {
                                          String id = _allCustomersLogic
                                              .allCustomers[index].id;
                                          print(id);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerDetailViewScreen(
                                                      searchString: id),
                                            ),
                                          );
                                        },
                                        leading: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                        title: Text(_allCustomersLogic
                                            .allCustomers[index]
                                            .returnNameAndSurname),
                                        subtitle: Text(
                                            '${_allCustomersLogic.allCustomers[index].phoneNumber.toString()} '),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              })
                          : _allCustomersLogic.foundCustomers.isNotEmpty
                              ?

                              //foundCustomers view
                              ListView.builder(
                                  itemCount:
                                      _allCustomersLogic.foundCustomers.length,
                                  itemBuilder: (context, index) => Card(
                                    key: ValueKey(_allCustomersLogic
                                        .foundCustomers[index].id),
                                    // color: Colors.amberAccent,
                                    elevation: 4,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: ListTile(
                                      onTap: () {
                                        // _allReservationsProvider.getReservationByCustomer(
                                        //     _allCustomersLogic.foundCustomers[index]);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           CustomerDetailViewScreen(
                                        //               customerDB: _allCustomersLogic
                                        //                   .foundCustomers[index])),
                                        // );
                                      },
                                      leading: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      title: Text(_allCustomersLogic
                                          .foundCustomers[index]
                                          .returnNameAndSurname),
                                      subtitle: Text(
                                          '${_allCustomersLogic.foundCustomers[index].phoneNumber.toString()} '),
                                    ),
                                  ),
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

//Consumer<AllCustomersLogic>(
//    builder: (context, _allCUstomersLogic, child) {
//      return ListView();
// });


//
// class AllCustomersScreen extends StatefulWidget {
//   static const routeName = '/AllCustomersScreen';
//
//   @override
//   State<AllCustomersScreen> createState() => _AllCustomersScreenState();
// }
//
// class _AllCustomersScreenState extends State<AllCustomersScreen> {
//   final int screenIndex = 2;
//   final TextEditingController? _searchController = TextEditingController();
//   bool seachBool = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     final _allCustomerLogicProvider =
//         Provider.of<AllCustomersScreenLogic>(context, listen: false);
//     // _allCustomerLogicProvider.initialShowedCustomers();
//     super.initState();
//     //AllCustomersScreenLogic.futureCustomers = _allCustomerLogicProvider.fetchCustomerDB();
//     _allCustomerLogicProvider.convertFutureListOfCustomerDBToList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var _allReservationsProvider = Provider.of<AllReservationsLogic>(context);
//     return Consumer<AllCustomersScreenLogic>(
//         builder: (context, _allCustomersLogic, child) {
//       // Future.delayed(Duration.zero, () {
//       //   //your code goes here
//       // });
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
//                 controller: _searchController,
//                 onChanged: (value) => _allCustomersLogic.runFilter(value),
//                 decoration: const InputDecoration(
//                     labelText: 'Search', suffixIcon: Icon(Icons.search)),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//
//               // Expanded(
//               //   child:
//               //   _allCustomersLogic.foundCustomers.isNotEmpty
//               //       ? FutureBuilder<List<CustomerDB>>(
//               //           future: AllCustomersScreenLogic.futureCustomers,
//               //           builder: (context, snapshot) {
//               //             if (snapshot.hasData) {
//               //               return ListView.builder(
//               //                 itemCount:
//               //                     _allCustomersLogic.foundCustomers.length,
//               //                 itemBuilder: (context, index) => Card(
//               //                   key: ValueKey(_allCustomersLogic
//               //                       .foundCustomers[index].id),
//               //                   // color: Colors.amberAccent,
//               //                   elevation: 4,
//               //                   margin:
//               //                       const EdgeInsets.symmetric(vertical: 10),
//               //                   child: ListTile(
//               //                     onTap: () {
//               //                       Navigator.pop(context);
//               //                     },
//               //                     leading: Text(
//               //                       (index + 1).toString(),
//               //                       style: const TextStyle(fontSize: 24),
//               //                     ),
//               //                     title: Text(_allCustomersLogic
//               //                         .foundCustomers[index]
//               //                         .returnNameAndSurname),
//               //                     subtitle: Text(
//               //                         '${_allCustomersLogic.foundCustomers[index].phoneNumber.toString()} '),
//               //                   ),
//               //                 ),
//               //               );
//               //             } else {
//               //               return const Center(
//               //                   child: CircularProgressIndicator());
//               //             }
//               //           })
//               //       : const Text(
//               //           'No results found',
//               //           style: TextStyle(fontSize: 24),
//               //         ),
//               // ),
//               Expanded(
//                   child:
//
//                       //Todo: la ricerca funziona e quando si cancella vengono mostrat correttamente tutti i customers, però alla prima apertura risulta "not found" e non so perché
//                       ///############CODICE DA SISTEMARE, ISOLARE E FATTORIZZARE############
//
//                       (_allCustomersLogic.foundCustomers.isEmpty &&
//                               _searchController != null)
//                           ?
//
//                           //allCustomersView
//                           FutureBuilder<List<CustomerDB>>(
//                               future: AllCustomersScreenLogic.futureCustomers,
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData) {
//                                   return ListView.builder(
//                                     itemCount:
//                                     _allCustomersLogic.foundCustomers.isEmpty &&
//                                         _searchController != null
//
//                                         ?
//
//                                         _allCustomersLogic.allCustomers.length
//
//                                         :
//
//                                         _allCustomersLogic.foundCustomers.isNotEmpty
//
//                                         ?
//
//                                         _allCustomersLogic.foundCustomers.length
//
//                                         :
//
//                                        [].length ,
//
//
//                                     itemBuilder: (context, index) => Card(
//                                       key: ValueKey(
//
//                                         _allCustomersLogic.foundCustomers.isEmpty &&
//                                         _searchController != null
//
//                                         ?
//
//                                         _allCustomersLogic.allCustomers[index].id
//
//                                         :
//
//                                         _allCustomersLogic.foundCustomers.isNotEmpty
//
//                                         ?
//
//                                         _allCustomersLogic.foundCustomers[index].id
//
//                                         :
//
//                                         [].length ,
//
//
//
//
//
//                                       ),
//                                       // color: Colors.amberAccent,
//                                       elevation: 4,
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 10),
//                                       child: ListTile(
//                                         onTap: () {
//                                           String id = _allCustomersLogic
//                                               .allCustomers[index].id;
//                                           print(id);
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   CustomerDetailViewScreen(
//                                                       searchString: id),
//                                             ),
//                                           );
//                                         },
//                                         leading: Text(
//                                           (index + 1).toString(),
//                                           style: const TextStyle(fontSize: 24),
//                                         ),
//                                         title: Text(_allCustomersLogic
//                                             .allCustomers[index]
//                                             .returnNameAndSurname),
//                                         subtitle: Text(
//                                             '${_allCustomersLogic.allCustomers[index].phoneNumber.toString()} '),
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   return const Center(
//                                       child: CircularProgressIndicator());
//                                 }
//                               })
//                           : _allCustomersLogic.foundCustomers.isNotEmpty
//                               ?
//
//                               //foundCustomers view
//                               ListView.builder(
//                                   itemCount:
//                                       _allCustomersLogic.foundCustomers.length,
//                                   itemBuilder: (context, index) => Card(
//                                     key: ValueKey(_allCustomersLogic
//                                         .foundCustomers[index].id),
//                                     // color: Colors.amberAccent,
//                                     elevation: 4,
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     child: ListTile(
//                                       onTap: () {
//                                         // _allReservationsProvider.getReservationByCustomer(
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
//                                       title: Text(_allCustomersLogic
//                                           .foundCustomers[index]
//                                           .returnNameAndSurname),
//                                       subtitle: Text(
//                                           '${_allCustomersLogic.foundCustomers[index].phoneNumber.toString()} '),
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

//Consumer<AllCustomersLogic>(
//    builder: (context, _allCUstomersLogic, child) {
//      return ListView();
// });
