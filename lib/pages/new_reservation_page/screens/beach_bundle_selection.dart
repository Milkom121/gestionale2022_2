import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../all_reservations_page/all_reservations_logic.dart';
import '../new_reservation_form_logic.dart';

List beachBundleItemList = List.generate(44, (index) => int);

class BeachBundleSelection extends StatelessWidget {
  const BeachBundleSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewReservationScreenLogic>(
      builder: (context, _reservationFormLogic, child) => AlertDialog(
        title: const Center(child: Text('Pool Seats')),
        content: Column(
          children: [
            Expanded(
              child: Container(
                height: 500.0, // Change as per your requirement
                width: 300.0, // Change as per your requirement
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 4 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: beachBundleItemList.length,
                  itemBuilder: (BuildContext context, index) {
                    return GridTile(
                      child: GestureDetector(
                        onTap: () {
                          _reservationFormLogic.addBeachBundle(index);
                        },
                        //quando premo un cerchio aggiungo il numero alla prenotazione
                        onLongPress: () {
                          _reservationFormLogic.removeBeachBundle(index);
                        },
                        child: Consumer<AllReservationsLogic>(
                          builder: (context, _allReservationLogic, child) =>
                              CircleAvatar(
                               backgroundColor:
                               _allReservationLogic
                                    .getAllBeachBundleReserved
                                    .contains(index + 1)
                                ? Colors.red
                                : NewReservationScreenLogic
                                        .reservationMap['beachBundle']
                                        .contains(index + 1)
                                    ? Colors.green
                                    : Colors.blue,
                                //NewReservationFormLogic.reservationMap['beach_bundle'].contains(index +1) ? Colors.red : Colors.blue,

                                //_allReservationLogic.allBeachBundleReserved.contains(index +1) | ReservationFormLogic.reservationMap['beach_bundle'].contains(index +1) ? Colors.red : Colors.blue,
                              child: Text((index + 1).toString()),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            color: Colors.green,
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context);
              print(_reservationFormLogic.getBeachBundleList);
              //_reservationFormLogic.notifyListener();
              _reservationFormLogic.calculateTotalCost();
            },
          ),
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

//Column(
//   children: [
//     Expanded(
//       child: Container(
//           height: 500.0, // Change as per your requirement
//           width: 300.0, // Change as per your requirement
//           child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 200,
//                   childAspectRatio: 4 / 2,
//                   crossAxisSpacing: 20,
//                   mainAxisSpacing: 20),
//               itemCount: poolBundleItemList.length,
//               itemBuilder: (BuildContext context, index) {
//                 return GridTile(
//                     child: GestureDetector(
//                       onTap: () {
//                       },
//                       onLongPress: () {
//
//                       },
//                       child: const CircleAvatar(
//                         backgroundColor:
//                              Colors.blue,
//                         child: Text('ciao'),
//                       ),
//                     );
//
//                 );
//               })),
//     ),
//   ],
// );;
