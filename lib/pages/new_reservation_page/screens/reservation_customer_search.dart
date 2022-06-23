import 'package:flutter/material.dart';
import 'package:gestionale2022_2/pages/new_reservation_page/new_reservation_form_logic.dart';
import 'package:provider/provider.dart';

import '../../all_reservations_page/all_reservations_logic.dart';
import '../../customers_page/all_customers_screen_logic.dart';

class ReservationCustomerSearch extends StatefulWidget {
  const ReservationCustomerSearch({
    Key? key,
  }) : super(key: key);

  //final Function(String title) getReservationNameAndSurname;

  @override
  State<ReservationCustomerSearch> createState() =>
      _ReservationCustomerSearchState();
}

class _ReservationCustomerSearchState extends State<ReservationCustomerSearch> {
  @override
  void initState() {
    // TODO: implement initState
    final _allCustomerLogicProvider =
        Provider.of<AllCustomersScreenLogic>(context, listen: false);
    _allCustomerLogicProvider.initialShowedCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _allReservationsProvider = Provider.of<AllReservationsLogic>(context);
    var _newReservationProvider = Provider.of<NewReservationFormLogic>(context);
    return Consumer<AllCustomersScreenLogic>(
      builder: (context, _allCustomersLogic, child) =>
          // Future.delayed(Duration.zero, () {
          //   //your code goes here
          // });

          AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) => _allCustomersLogic.runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _allCustomersLogic.foundCustomers.isNotEmpty
                      ? ListView.builder(
                          itemCount: _allCustomersLogic.foundCustomers.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(
                                _allCustomersLogic.foundCustomers[index].id),
                            // color: Colors.amberAccent,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              onTap: () {
                                NewReservationFormLogic
                                        .reservationMap['customer'] =
                                    _allCustomersLogic.foundCustomers[index];

                                // _newReservationProvider
                                //     .setReservationCustomerNameAndSurname(
                                //     _allCustomersLogic.foundCustomers[index].name + ' ' + _allCustomersLogic.foundCustomers[index].surname
                                //         );

                                // _newReservationProvider
                                //     .setReservationCustomerNameAndSurname(
                                //         CustomerDB.fromMap(CustomerDb._allCustomersLogic.foundCustomers[index]).returnNameAndSurname
                                //             ); //TODO: modificato da .returnNameAndSurname ad .id

                                Navigator.pop(context);
                              },
                              leading: Text(
                                (index + 1).toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Text(_allCustomersLogic
                                  .foundCustomers[index].returnNameAndSurname),
                              subtitle: Text(
                                  '${_allCustomersLogic.foundCustomers[index].phoneNumber.toString()} '),
                            ),
                          ),
                        )
                      : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          // IconButton(
          //   color: Colors.green,
          //   icon: const Icon(Icons.check),
          //   onPressed: () {
          //     Navigator.pop(context);
          //
          //
          //   },
          // ),
          IconButton(
            color: Colors.red,
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

//Consumer<AllCustomersLogic>(
//    builder: (context, _allCUstomersLogic, child) {
//      return ListView();
// });
