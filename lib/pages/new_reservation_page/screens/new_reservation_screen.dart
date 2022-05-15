import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestionale2022_2/pages/new_reservation_page/screens/reservation_customer_search.dart';
import 'package:provider/provider.dart';

import '../../../models/reservation.dart';
import '../../all_reservations_page/all_reservations_logic.dart';
import '../new_reservation_form_logic.dart';
import '../widgets/beach_bundle_form.dart';
import '../widgets/inc_dec_widget.dart';

class NewReservationScreen extends StatelessWidget {
  NewReservationScreen({Key? key}) : super(key: key);

  static const routeName = '/NewReservationScreen';

  final int screenIndex = 1;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // final _reservationFormLogic = Provider.of<ReservationFormLogic>(context);//mi collego al file con la logica di questa schermata

    bool _discountVisibility = true;
    //CustomerDB _customerDB = NewReservationFormLogic.reservationMap['customer'] ;
    return Consumer<NewReservationFormLogic>(
      builder: (context, _newReservationFormLogic, child) => Material(
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
                    ///CUSTOMER
                    TextFormField(
                     initialValue: _newReservationFormLogic.reservationCustomerNameAndSurname,
                      readOnly: true,
                      decoration:
                          const InputDecoration(
                              icon: Icon(Icons.person),
                          label: Text('Customer'),),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ReservationCustomerSearch();
                            });
                      },
                    ),

                    // FormBuilderTextField(
                    //   onTap: ,
                    //   decoration: const InputDecoration(
                    //     label: Text('Customer'),
                    //     icon: Icon(Icons.person),
                    //   ),
                    //   name: 'customer',
                    //   validator: FormBuilderValidators.compose([
                    //     // FormBuilderValidators.required(context),
                    //     // FormBuilderValidators.email(context),
                    //   ]),
                    // ),

                    ///DATE + DAY SLOT
                    Row(
                      children: [
                        ///DATA///
                        Expanded(
                          child: DateTimePicker(
                              initialDate: DateTime.now(),
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
                        BeachBundleForm(),
                        // ricordarsi di non aggiungere "const" se si desidera evitare bestemmie

                        ///000000000000000000000000000000\0000000000000000000000000000000000\000000000000000000000000000000\
                      ],
                    ),

                    const SizedBox(height: 50),

                    ///BOTTONE SAVE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 40),

                        ///PREZZO TOTALE
                        Container(
                          child: Center(
                            child: Text(
                              '€ ' +
                                  NewReservationFormLogic
                                      .reservationMap['total_cost']
                                      .toString(),
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ),

                        //const SizedBox(width: 50),

                        ElevatedButton(
                          onPressed: () {
                            print(_newReservationFormLogic.reservationCustomerNameAndSurname);
                            _newReservationFormLogic.calculateTotalCost();
                            print(NewReservationFormLogic.reservationMap);


                            //TODO aggiungere logica per aggiungere la prenotazione a all_prenotation_logic

                            ///prendo la map della reservation che ho costruito in questo form e la passo al
                            ///metodo mapToReservation della classe Reservation che mi restituisce una istanza di Reservation con tutti i dati
                            /// che posso a sua volta passare al metodo setter addNewReservation della classe AllReservationLogic che lo aggiungerà alla lista
                            /// delle prenotazioni.

                            AllReservationsLogic().addNewReservation(
                                Reservation.mapToReservation(
                                    NewReservationFormLogic.reservationMap));

                            _newReservationFormLogic.restoreReservationMap();
                            _newReservationFormLogic.restoreReservationCustomerNameAndSurname();
                            Navigator.pop(context);
                            print(NewReservationFormLogic.reservationMap);

                            // Navigator.pushNamed(
                            //     context, AllReservationsScreen.routeName);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:provider/provider.dart';
//
// import '../../../common_widgets/app_navigation_bar.dart';
// import '../../../models/reservation.dart';
// import '../../all_reservations_page/all_reservations_logic.dart';
// import '../../all_reservations_page/all_reservations_screen.dart';
// import '../new_reservation_form_logic.dart';
// import '../widgets/beach_bundle_form.dart';
// import '../widgets/inc_dec_widget.dart';
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
//       builder: (context, _newReservationFormLogic, child) =>
//         Scaffold(
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
//                                     _newReservationFormLogic.addValueToReservation(
//                                         'date', day);
//                                     _newReservationFormLogic.calculateTotalCost();
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
//                                     _newReservationFormLogic.setDiscountToZero();
//                                   } else {
//                                     _discountVisibility = true;
//                                   }
//                                   _newReservationFormLogic.addValueToReservation(
//                                       'day_slot',
//                                       value); //salvo il valore nell'apposito campo della map nel file logic.dart
//                                   _newReservationFormLogic.calculateTotalCost();
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
//                                   _newReservationFormLogic.addValueToReservation(
//                                       'tickets', value);
//                                   _newReservationFormLogic.calculateTotalCost();
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
//                                     _newReservationFormLogic.addValueToReservation(
//                                         'discount', value);
//                                     _newReservationFormLogic.calculateTotalCost();
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
//                                     _newReservationFormLogic.addValueToReservation(
//                                         'beach_chairs', value);
//                                    // print(ReservationFormLogic.reservationMap['beach_chairs']);
//                                     _newReservationFormLogic.calculateTotalCost();
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
//                               _newReservationFormLogic.calculateTotalCost();
//                               print(NewReservationFormLogic.reservationMap);
//
//                               //TODO aggiungere logica per aggiungere la prenotazione a all_prenotation_logic
//
//                               ///prendo la map della reservation che ho costruito in questo form e la passo al
//                               ///metodo mapToReservation della classe Reservation che mi restituisce una istanza di Reservation con tutti i dati
//                               /// che posso a sua volta passare al metodo setter addNewReservation della classe AllReservationLogic che lo aggiungerà alla lista
//                               /// delle prenotazioni.
//                               AllReservationsLogic().addNewReservation (
//                                   Reservation.mapToReservation(
//                                       NewReservationFormLogic.reservationMap));
//
//                               _newReservationFormLogic.restoreReservationMap();
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
//
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
