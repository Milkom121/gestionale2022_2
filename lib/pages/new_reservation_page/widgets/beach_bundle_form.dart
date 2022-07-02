import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../new_reservation_form_logic.dart';
import '../screens/beach_bundle_selection.dart';

class BeachBundleForm extends StatelessWidget {
  const BeachBundleForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewReservationScreenLogic>(
      create: (_) => NewReservationScreenLogic(),
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
                child: Consumer<NewReservationScreenLogic>(
                    builder: (context, _newReservationFormLogic, child) {
                  return ListView.builder(
                    itemCount: _newReservationFormLogic.getBeachBundleList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CircleAvatar(
                        radius: 12,
                        child: Text(_newReservationFormLogic.getBeachBundleList[index]
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
