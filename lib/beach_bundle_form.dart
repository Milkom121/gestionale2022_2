import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'beach_bundle_selection.dart';
import 'logic.dart';

class BeachBundleForm extends StatelessWidget {
  const BeachBundleForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReservationFormLogic>(
      create: (_) => ReservationFormLogic(),
      child: Expanded(
          child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.beach_access),
              SizedBox(width: 15),
              Text('Beach bundle'),
            ],
          ),

          ///QUESTA è LA LINEA CHE STA SOTTO IL FORM
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const BeachBundleSelection();
                  });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: SizedBox(
                height: 33,
                child: Consumer<ReservationFormLogic>(
                    builder: (context, _reservationFormLogic, child) {
                  return ListView.builder(
                    itemCount: _reservationFormLogic.beachBundleList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CircleAvatar(
                        radius: 12,
                        child: Text(_reservationFormLogic.beachBundleList[index]
                            .toString()),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0, right: 30),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[400],
            ),
          )
        ],
      )),
    );
  }
}
