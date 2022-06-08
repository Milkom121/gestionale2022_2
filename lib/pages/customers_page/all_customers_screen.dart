import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestionale2022_2/pages/customers_page/all_customers_screen_logic.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_navigation_bar.dart';
import '../../models/users_types.dart';
import '../all_reservations_page/all_reservations_logic.dart';
import 'all_customers_screen_logic.dart';

class AllCustomersScreen extends StatefulWidget {
  static const routeName = '/AllCustomersScreen';

  @override
  State<AllCustomersScreen> createState() => _AllCustomersScreenState();
}

class _AllCustomersScreenState extends State<AllCustomersScreen> {
  final int screenIndex = 2;



  @override
  void initState() {
    // TODO: implement initState
    final _allCustomerLogicProvider =
    Provider.of<AllCustomersScreenLogic>(context, listen: false);
    // _allCustomerLogicProvider.initialShowedCustomers();
    super.initState();
    AllCustomersScreenLogic.futureCustomers = _allCustomerLogicProvider.fetchCustomerDB();

  }


  @override
  Widget build(BuildContext context) {
    var _allReservationsProvider = Provider.of<AllReservationsLogic>(context);
    return Consumer<AllCustomersScreenLogic>(
        builder: (context, _allCustomersLogic, child) {
          Future.delayed(Duration.zero, () {
            //your code goes here
          });

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
                    onChanged: (value) => _allCustomersLogic.runFilter(value),
                    decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: FutureBuilder<List<CustomerDB>>(
                      future: AllCustomersScreenLogic.futureCustomers,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: const Color(0xff97FFFF),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].name +
                                        ' ' +
                                        snapshot.data![index].surname,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(snapshot.data![index].email),
                                  Text(snapshot.data![index].phoneNumber),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    // _allCustomersLogic.foundCustomers.isNotEmpty
                    //     ? ListView.builder(
                    //   itemCount: _allCustomersLogic.foundCustomers.length,
                    //   itemBuilder: (context, index) => Card(
                    //     key: ValueKey(
                    //         _allCustomersLogic.foundCustomers[index].id),
                    //     // color: Colors.amberAccent,
                    //     elevation: 4,
                    //     margin: const EdgeInsets.symmetric(vertical: 10),
                    //     child: ListTile(
                    //       onTap: () {
                    //         _allReservationsProvider.getReservationByCustomer(
                    //             _allCustomersLogic.foundCustomers[index]);
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   CustomerDetailViewScreen(
                    //                       customerDB: _allCustomersLogic
                    //                           .foundCustomers[index])),
                    //         );
                    //       },
                    //       leading: Text(
                    //         (index + 1).toString(),
                    //         style: const TextStyle(fontSize: 24),
                    //       ),
                    //       title: Text(_allCustomersLogic
                    //           .foundCustomers[index].returnNameAndSurname),
                    //       subtitle: Text(
                    //           '${_allCustomersLogic.foundCustomers[index].phoneNumber.toString()} '),
                    //     ),
                    //   ),
                    // )
                    //     : const Text(
                    //   'No results found',
                    //   style: TextStyle(fontSize: 24),
                    // ),
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
