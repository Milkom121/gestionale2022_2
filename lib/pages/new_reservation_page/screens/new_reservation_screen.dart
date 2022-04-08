import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestionale2022_2/common_widgets/app_navigation_bar.dart';
import 'package:gestionale2022_2/models/reservation.dart';
import 'package:gestionale2022_2/pages/all_reservations_page/all_reservations_logic.dart';
import 'package:gestionale2022_2/pages/all_reservations_page/all_reservations_screen.dart';
import 'package:gestionale2022_2/pages/new_reservation_page/widgets/inc_dec_widget.dart';
import 'package:provider/provider.dart';

import '../new_reservation_form_logic.dart';
import '../widgets/beach_bundle_form.dart';

class NewReservationScreen extends StatelessWidget {
  NewReservationScreen({Key? key}) : super(key: key);

  static const routeName = '/NewReservationScreen';

  final int screenIndex = 1;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // final _reservationFormLogic = Provider.of<ReservationFormLogic>(context);//mi collego al file con la logica di questa schermata

    bool _discountVisibility = true;

    return Consumer<NewReservationFormLogic>(
      builder: (context, _newReservationFormLogic, child) =>
        Scaffold(
          bottomNavigationBar: AppNavigationBar(screenIndex),
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

                                  initialDate: DateTime.now() ,
                                  type: DateTimePickerType.date,
                                  dateMask: 'dd MMM, yyyy',
                                  // controller: _timeController,
                                  //initialValue: _initialValue,
                                  firstDate: DateTime(2018),
                                  lastDate: DateTime(2100),
                                  icon: const Icon(Icons.event),
                                  dateLabelText: 'Date',
                                  onChanged: (day) {
                                    _newReservationFormLogic.addValueToReservation(
                                        'date', day);
                                    _newReservationFormLogic.calculateTotalCost();
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
                                    _newReservationFormLogic.setDiscountToZero();
                                  } else {
                                    _discountVisibility = true;
                                  }
                                  _newReservationFormLogic.addValueToReservation(
                                      'day_slot',
                                      value); //salvo il valore nell'apposito campo della map nel file logic.dart
                                  _newReservationFormLogic.calculateTotalCost();
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
                                  _newReservationFormLogic.addValueToReservation(
                                      'tickets', value);
                                  _newReservationFormLogic.calculateTotalCost();
                                  //_reservationFormLogic.calculateTotalCost();
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
                                    _newReservationFormLogic.addValueToReservation(
                                        'discount', value);
                                    _newReservationFormLogic.calculateTotalCost();
                                    //_reservationFormLogic.calculateTotalCost();
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
                                    _newReservationFormLogic.addValueToReservation(
                                        'beach_chairs', value);
                                   // print(ReservationFormLogic.reservationMap['beach_chairs']);
                                    _newReservationFormLogic.calculateTotalCost();
                                    //_reservationFormLogic.calculateTotalCost();
                                  }),
                            ),

                            ///00000000000000000000000000000\0000000000000000000000000000000000\00000000000000000000000000000000\
                            ///DA QUI IN AVANTI FINO AL PROSSIMO SEGNALE COSTRUIRò IL SISTEMA DI GESTIONE DEI BUNDEL BEACH.
                            ///SUCCESSIVAMENTE QUESTO CODICE VERRA ASPORTATO E TRADOTTO IN UN WIDGET AUTONOMO

                            ///Beach Bundle selection
                             BeachBundleForm(), // ricordarsi di non aggiungere "const" se si desidera evitare bestemmie

                            ///000000000000000000000000000000\0000000000000000000000000000000000\000000000000000000000000000000\
                          ],
                        ),

                        const SizedBox(height: 50),

                        Container(
                          child: Center(
                            child: Text(
                              NewReservationFormLogic.reservationMap['total_cost']
                                  .toString(),
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        ),

                        const SizedBox(height: 150),

                        ///BOTTONE SAVE
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              _newReservationFormLogic.calculateTotalCost();
                              print(NewReservationFormLogic.reservationMap);

                              //TODO aggiungere logica per aggiungere la prenotazione a all_prenotation_logic

                              ///prendo la map della reservation che ho costruito in questo form e la passo al
                              ///metodo mapToReservation della classe Reservation che mi restituisce una istanza di Reservation con tutti i dati
                              /// che posso a sua volta passare al metodo setter addNewReservation della classe AllReservationLogic che lo aggiungerà alla lista
                              /// delle prenotazioni.
                              AllReservationLogic().addNewReservation (
                                  Reservation.mapToReservation(
                                      NewReservationFormLogic.reservationMap));

                              _newReservationFormLogic.restoreReservationMap();
                              //print(ReservationFormLogic.reservationMap);


                              Navigator.pushNamed(context, AllReservationsScreen.routeName);
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

    );
  }
}
















// import 'dart:async';
//
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:gestionale2022_2/common_widgets/app_navigation_bar.dart';
// import 'package:gestionale2022_2/pages/all_reservations_page/all_reservations_screen.dart';
// import 'package:gestionale2022_2/pages/all_reservations_page/all_reservations_logic.dart';
// import 'package:gestionale2022_2/pages/new_reservation_page/screens/beach_bundle_selection.dart';
// import 'package:gestionale2022_2/pages/new_reservation_page/widgets/inc_dec_widget.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
//
// import '../new_reservation_form_logic.dart';
// import '../widgets/beach_bundle_form.dart';
// import 'package:gestionale2022_2/models/reservation.dart';
//
// class NewReservationScreen extends StatelessWidget {
//   NewReservationScreen({Key? key}) : super(key: key);
//
//   static const routeName = '/NewReservationScreen';
//
//   final int screenIndex = 1;
//
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   @override
//   Widget build(BuildContext context) {
//     // final _reservationFormLogic = Provider.of<ReservationFormLogic>(context);//mi collego al file con la logica di questa schermata
//
//     bool _discountVisibility = true;
//
//     return Consumer<NewReservationFormLogic>(
//       builder: (context, _reservationFormLogic, child) => Scaffold(
//         body: Scaffold(
//           bottomNavigationBar: AppNavigationBar(screenIndex),
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
//                 child: FormBuilder(
//                   key: _formKey,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ///DATE + DAY SLOT
//                         Row(
//                           children: [
//                             ///DATA///
//                             Expanded(
//                               child: DateTimePicker(
//
//                                   initialDate: DateTime.now() ,
//                                   type: DateTimePickerType.date,
//                                   dateMask: 'dd MMM, yyyy',
//                                   // controller: _timeController,
//                                   //initialValue: _initialValue,
//                                   firstDate: DateTime(2018),
//                                   lastDate: DateTime(2100),
//                                   icon: const Icon(Icons.event),
//                                   dateLabelText: 'Date',
//                                   onChanged: (day) {
//                                     _reservationFormLogic.addValueToReservation(
//                                         'date', day);
//                                     _reservationFormLogic.calculateTotalCost();
//                                   }),
//                             ),
//
//                             const SizedBox(
//                               width: 10,
//                             ),
//
//                             ///TIPOLOGIA DI BIGLIETTO
//                             Expanded(
//                               child: FormBuilderChoiceChip<dynamic>(
//                                 decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     label: Text('Choose day slot')),
//                                 spacing: 5,
//                                 selectedColor: Colors.blue,
//                                 backgroundColor: Colors.blue[100],
//                                 name: 'day_slot',
//                                 initialValue: 8,
//                                 options: const [
//                                   FormBuilderFieldOption(value: 'entire'),
//                                   FormBuilderFieldOption(value: 'half'),
//                                   FormBuilderFieldOption(value: 'late'),
//                                 ],
//                                 onChanged: (value) {
//                                   if (value == 'late') {
//                                     _discountVisibility = false;
//                                     _reservationFormLogic.setDiscountToZero();
//                                   } else {
//                                     _discountVisibility = true;
//                                   }
//                                   _reservationFormLogic.addValueToReservation(
//                                       'day_slot',
//                                       value); //salvo il valore nell'apposito campo della map nel file logic.dart
//                                   _reservationFormLogic.calculateTotalCost();
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 30),
//
//                         ///TICKETS + DISCOUNT
//                         Row(
//                           children: [
//                             ///Tickets
//                             Expanded(
//                               child: IncDecWidget(
//                                 title: const Text('Tickets'),
//                                 icon: const Icon(Icons.people),
//                                 onChanged: (value) {
//                                   _reservationFormLogic.addValueToReservation(
//                                       'tickets', value);
//                                   _reservationFormLogic.calculateTotalCost();
//                                   //_reservationFormLogic.calculateTotalCost();
//                                   //print(value);
//                                 },
//                               ),
//                             ),
//
//                             ///Discount
//                             Visibility(
//                               visible: _discountVisibility,
//                               child: Expanded(
//                                 child: IncDecWidget(
//                                   title: const Text('Discounts'),
//                                   icon: const Icon(Icons.euro),
//                                   onChanged: (value) {
//                                     _reservationFormLogic.addValueToReservation(
//                                         'discount', value);
//                                     _reservationFormLogic.calculateTotalCost();
//                                     //_reservationFormLogic.calculateTotalCost();
//                                   },
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//
//                         const SizedBox(height: 40),
//
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ///BEACH CHAIRS
//                             Expanded(
//                               child: IncDecWidget(
//                                   title: const Text('Beach chairs'),
//                                   icon: const Icon(Icons.chair_alt),
//                                   onChanged: (value) {
//                                     _reservationFormLogic.addValueToReservation(
//                                         'beach_chairs', value);
//                                    // print(ReservationFormLogic.reservationMap['beach_chairs']);
//                                     _reservationFormLogic.calculateTotalCost();
//                                     //_reservationFormLogic.calculateTotalCost();
//                                   }),
//                             ),
//
//                             ///00000000000000000000000000000\0000000000000000000000000000000000\00000000000000000000000000000000\
//                             ///DA QUI IN AVANTI FINO AL PROSSIMO SEGNALE COSTRUIRò IL SISTEMA DI GESTIONE DEI BUNDEL BEACH.
//                             ///SUCCESSIVAMENTE QUESTO CODICE VERRA ASPORTATO E TRADOTTO IN UN WIDGET AUTONOMO
//
//                             ///Beach Bundle selection
//                              BeachBundleForm(), // ricordarsi di non aggiungere "const" se si desidera evitare bestemmie
//
//                             ///000000000000000000000000000000\0000000000000000000000000000000000\000000000000000000000000000000\
//                           ],
//                         ),
//
//                         const SizedBox(height: 50),
//
//                         Container(
//                           child: Center(
//                             child: Text(
//                               NewReservationFormLogic.reservationMap['total_cost']
//                                   .toString(),
//                               style: const TextStyle(fontSize: 36),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 150),
//
//                         ///BOTTONE SAVE
//                         Align(
//                           alignment: Alignment.bottomCenter,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               _reservationFormLogic.calculateTotalCost();
//                               print(NewReservationFormLogic.reservationMap);
//
//                               //TODO aggiungere logica per aggiungere la prenotazione a all_prenotation_logic
//
//                               ///prendo la map della reservation che ho costruito in questo form e la passo al
//                               ///metodo mapToReservation della classe Reservation che mi restituisce una istanza di Reservation con tutti i dati
//                               /// che posso a sua volta passare al metodo setter addNewReservation della classe AllReservationLogic che lo aggiungerà alla lista
//                               /// delle prenotazioni.
//                               AllReservationLogic().addNewReservation (
//                                   Reservation.mapToReservation(
//                                       NewReservationFormLogic.reservationMap));
//
//                               _reservationFormLogic.restoreReservationMap();
//                               //print(ReservationFormLogic.reservationMap);
//
//
//                               Navigator.pushNamed(context, AllReservationsScreen.routeName);
//                             },
//
//
//
//                             child: const Text('Save'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//










///









// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:provider/provider.dart';
// import 'beach_bundle_form.dart';
// import 'inc_dec_widget.dart';
// import 'new_reservation_form_logic.dart';
//
// class ReservationScreen extends StatelessWidget {
//   ReservationScreen({Key? key}) : super(key: key);
//
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   @override
//   Widget build(BuildContext context) {
//     // final _reservationFormLogic = Provider.of<ReservationFormLogic>(context);//mi collego al file con la logica di questa schermata
//
//     bool _discountVisibility = true;
//
//     return Consumer<ReservationFormLogic>(
//       builder: (context, _reservationFormLogic, child) => Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
//               child: FormBuilder(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ///DATE + DAY SLOT
//                       Row(
//                         children: [
//                           ///DATA///
//                           Expanded(
//                             child: DateTimePicker(
//                                 type: DateTimePickerType.date,
//                                 dateMask: 'dd MMM, yyyy',
//                                 // controller: _timeController,
//                                 //initialValue: _initialValue,
//                                 firstDate: DateTime(2000),
//                                 lastDate: DateTime(2100),
//                                 icon: const Icon(Icons.event),
//                                 dateLabelText: 'Date',
//                                 onChanged: (day) {
//                                   _reservationFormLogic.addValueToReservation(
//                                       'date', day);
//
//                                 }),
//                           ),
//
//                           const SizedBox(
//                             width: 10,
//                           ),
//
//                           ///TIPOLOGIA DI BIGLIETTO
//                           Expanded(
//                             child: FormBuilderChoiceChip<dynamic>(
//                               decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   label: Text('Choose day slot')),
//                               spacing: 5,
//                               selectedColor: Colors.blue,
//                               backgroundColor: Colors.blue[100],
//                               name: 'day_slot',
//                               initialValue: 8,
//                               options: const [
//                                 FormBuilderFieldOption(value: 'entire'),
//                                 FormBuilderFieldOption(value: 'half'),
//                                 FormBuilderFieldOption(value: 'late'),
//                               ],
//                               onChanged: (value) {
//                                 if (value == 'late') {
//                                   _discountVisibility = false;
//                                 } else {
//                                   _discountVisibility = true;
//                                 }
//                                 _reservationFormLogic.addValueToReservation(
//                                     'day_slot',
//                                     value); //salvo il valore nell'apposito campo della map nel file new_reservation_form_logic.dart
//                                 print(_discountVisibility);
//                                 print(ReservationFormLogic.reservationMap['day_slot']);
//
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       ///TICKETS + DISCOUNT
//                       Row(
//                         children: [
//                           ///Tickets
//                           Expanded(
//                             child: IncDecWidget(
//                               title: const Text('Tickets'),
//                               icon: const Icon(Icons.people),
//                               onChanged: (value) {
//                                 _reservationFormLogic.addValueToReservation(
//                                     'tickets', value);
//                                 _reservationFormLogic.calculateTotalCost();
//                                 //print(value);
//                               },
//                             ),
//                           ),
//
//                           ///Discount
//                           Visibility(
//                             visible: _discountVisibility,
//                             child: Expanded(
//                               child: IncDecWidget(
//                                 title: const Text('Discounts'),
//                                 icon: const Icon(Icons.euro),
//                                 onChanged: (value) {
//                                   _reservationFormLogic.addValueToReservation(
//                                       'discount', value);
//                                   _reservationFormLogic.calculateTotalCost();
//                                 },
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//
//                       const SizedBox(height: 40),
//
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ///BEACH CHAIRS
//                           Expanded(
//                             child: IncDecWidget(
//                                 title: const Text('Beach chairs'),
//                                 icon: const Icon(Icons.chair_alt),
//                                 onChanged: (value) {
//                                   _reservationFormLogic.addValueToReservation(
//                                       'beach_chairs', value);
//                                   print(ReservationFormLogic.reservationMap['beach_chairs']);
//                                   _reservationFormLogic.calculateTotalCost();
//                                 }),
//                           ),
//
//                           ///00000000000000000000000000000\0000000000000000000000000000000000\00000000000000000000000000000000\
//                           ///DA QUI IN AVANTI FINO AL PROSSIMO SEGNALE COSTRUIRò IL SISTEMA DI GESTIONE DEI BUNDEL BEACH.
//                           ///SUCCESSIVAMENTE QUESTO CODICE VERRA ASPORTATO E TRADOTTO IN UN WIDGET AUTONOMO
//
//                           ///Beach Bundle selection
//                           BeachBundleForm(),
//                           ///000000000000000000000000000000\0000000000000000000000000000000000\000000000000000000000000000000\
//                         ],
//                       ),
//
//                       SizedBox(height: 50),
//
//                       Container(
//                         child: Center(
//                           child: Text(ReservationFormLogic.reservationMap['total_cost'].toString(),style: TextStyle(fontSize: 36),),
//                         ),
//                       ),
//
//                       const SizedBox(height: 150),
//
//                       ///BOTTONE SAVE
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             print(ReservationFormLogic.reservationMap);
//                             print(_reservationFormLogic.returnDayName());
//                           },
//                           child: const Text('Save'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
