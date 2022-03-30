import 'dart:async';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gestionale2022_2/beach_bundle_selection.dart';
import 'package:gestionale2022_2/inc_dec_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'logic.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ReservationFormLogic(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage3(),
    );
  }
}

class HomePage3 extends StatelessWidget {
  HomePage3({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // final _reservationFormLogic = Provider.of<ReservationFormLogic>(context);//mi collego al file con la logica di questa schermata

    bool _discountVisibility = true;

    return ChangeNotifierProvider<ReservationFormLogic>(
      create: (context) => ReservationFormLogic(),
      child: Consumer<ReservationFormLogic>(
        builder: (context, _reservationFormLogic, child) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///DATE + DAY SLOT
                        Row(
                          children: [
                            ///DATA///
                            Expanded(
                              child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'dd MMM, yyyy',
                                  // controller: _timeController,
                                  //initialValue: _initialValue,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  icon: const Icon(Icons.event),
                                  dateLabelText: 'Date',
                                  onChanged: (day) {
                                    _reservationFormLogic.addValueToReservation(
                                        'date', day);

                                  }),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            ///TIPOLOGIA DI BIGLIETTO
                            Expanded(
                              child: FormBuilderChoiceChip<dynamic>(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    label: Text('Choose day slot')),
                                spacing: 5,
                                selectedColor: Colors.blue,
                                backgroundColor: Colors.blue[100],
                                name: 'day_slot',
                                initialValue: 8,
                                options: const [
                                  FormBuilderFieldOption(value: 'entire'),
                                  FormBuilderFieldOption(value: 'half'),
                                  FormBuilderFieldOption(value: 'late'),
                                ],
                                onChanged: (value) {
                                  if (value == 'late') {
                                    _discountVisibility = false;
                                  } else {
                                    _discountVisibility = true;
                                  }
                                  _reservationFormLogic.addValueToReservation(
                                      'day_slot',
                                      value); //salvo il valore nell'apposito campo della map nel file logic.dart
                                  print(_discountVisibility);
                                  print(ReservationFormLogic.reservationMap['day_slot']);

                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        ///TICKETS + DISCOUNT
                        Row(
                          children: [
                            ///Tickets
                            Expanded(
                              child: IncDecWidget(
                                title: const Text('Tickets'),
                                icon: const Icon(Icons.people),
                                onChanged: (value) {
                                  _reservationFormLogic.addValueToReservation(
                                      'tickets', value);
                                  _reservationFormLogic.calculateTotalCost();
                                  //print(value);
                                },
                              ),
                            ),

                            ///Discount
                            Visibility(
                              visible: _discountVisibility,
                              child: Expanded(
                                child: IncDecWidget(
                                  title: const Text('Discounts'),
                                  icon: const Icon(Icons.euro),
                                  onChanged: (value) {
                                    _reservationFormLogic.addValueToReservation(
                                        'discount', value);
                                    _reservationFormLogic.calculateTotalCost();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 40),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///BEACH CHAIRS
                            Expanded(
                              child: IncDecWidget(
                                  title: const Text('Beach chairs'),
                                  icon: const Icon(Icons.chair_alt),
                                  onChanged: (value) {
                                    _reservationFormLogic.addValueToReservation(
                                        'beach_chairs', value);
                                    print(ReservationFormLogic.reservationMap['beach_chairs']);
                                    _reservationFormLogic.calculateTotalCost();
                                  }),
                            ),

                            ///00000000000000000000000000000\0000000000000000000000000000000000\00000000000000000000000000000000\
                            ///DA QUI IN AVANTI FINO AL PROSSIMO SEGNALE COSTRUIRò IL SISTEMA DI GESTIONE DEI BUNDEL BEACH.
                            ///SUCCESSIVAMENTE QUESTO CODICE VERRA ASPORTATO E TRADOTTO IN UN WIDGET AUTONOMO

                            ///Beach Bundle selection
                            Expanded(
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
                                          return BeachBundleSelection();
                                        });
                                  },
                                  child: Container(
                                    height: 33,
                                    child: ListView.builder(
                                      itemCount: _reservationFormLogic
                                          .beachBundleList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return CircleAvatar(
                                          radius: 12,
                                          child: Text(_reservationFormLogic
                                              .beachBundleList[index]
                                              .toString()),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 38.0, right: 30),
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey[400],
                                  ),
                                )
                              ],
                            )),
                            ///000000000000000000000000000000\0000000000000000000000000000000000\000000000000000000000000000000\
                          ],
                        ),

                        Container(
                          child: Center(
                            child: Text(ReservationFormLogic.reservationMap['total_cost'].toString()),
                          ),
                        ),

                        const SizedBox(height: 150),

                        ///BOTTONE SAVE
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              print(ReservationFormLogic.reservationMap);
                              print(_reservationFormLogic.returnDayName());
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//FormBuilderTextField(
//   decoration: const InputDecoration(
//     label: Text('Email'),
//   ),
//   name: 'email',
//   validator: FormBuilderValidators.compose([
//     FormBuilderValidators.required(context),
//     FormBuilderValidators.email(context),
//   ]),
// ),
// FormBuilderTextField(
//   name: 'password',
//   validator: FormBuilderValidators.compose([
//     FormBuilderValidators.required(context),
//     FormBuilderValidators.minLength(context, 6),
//   ]),
// ),
