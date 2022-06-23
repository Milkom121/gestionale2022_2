//
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:gestionale2022_2/pages/new_reservation_page/screens/new_reservation_screen.dart';
// import 'package:provider/provider.dart';
//
// import '../../../models/reservation.dart';
// import '../../common_widgets/app_navigation_bar.dart';
// import '../../models/reservation.dart';
// import '../all_reservations_logic.dart';
// import 'all_reservations_logic.dart';
//
// class AllReservationsScreen extends StatelessWidget {
//   static const routeName = '/AllReservationsScreen';
//   final int screenIndex = 1;
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   AllReservationsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     AllReservationsLogic _reservationsProvider =
//     Provider.of<AllReservationsLogic>(context);
//
//     //List<Reservation> _currentReservationList = [];
//
//     return Consumer<AllReservationsLogic>(
//       builder: (context, _allReservationsLogic, child) {
//         // Future.delayed(Duration.zero, () async {
//         //   _allReservationsLogic.clearAllFoundReservationsList();
//         // });
//
//         List<Reservation> _currentReservationList =
//             _allReservationsLogic.getAllFoundReservations;
//
//         // if(_searchVisibility) {
//         //   _currentReservationList = [...AllReservationsLogic.allFoundReservationsList];
//         // } else {
//         //   _reservationsProvider.clearAllFoundReservationsList();
//         //   _currentReservationList = [..._reservationsProvider.getAllReservations];
//         // }
//         //
//
//         return Scaffold(
//           appBar: AppBar(title: const Text('Reservations'),),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               showModalBottomSheet<dynamic>(
//                   isScrollControlled: true,
//                   context: context,
//                   builder: (BuildContext bc) {
//                     return Wrap(children: <Widget>[NewReservationScreen()]);
//                   });
//               // showModalBottomSheet<void>(
//               //   context: context,
//               //   builder: (BuildContext context) {
//               //     return NewReservationScreen();
//               //   },
//               // );
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) =>  NewReservationScreen()),
//               // );
//             },
//             child: const Icon(Icons.add),
//           ),
//           bottomNavigationBar: AppNavigationBar(screenIndex),
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // SearchFormWidget(),
//                   ///SEARCH WIDGET - lo tenevo in un altro file ma così facendo non si vedeva la data selezionata
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: FormBuilder(
//                         key: _formKey,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             FormBuilderTextField(
//                               decoration: const InputDecoration(
//                                 label: Text('Customer'),
//                                 icon: Icon(Icons.person),
//                               ),
//                               name: 'customer',
//                               validator: FormBuilderValidators.compose([
//                                 // FormBuilderValidators.required(context),
//                                 // FormBuilderValidators.email(context),
//                               ]),
//                             ),
//
//                             DateTimePicker(
//                                 initialDate: DateTime.now(),
//                                 type: DateTimePickerType.date,
//                                 dateMask: 'dd MMM, yyyy',
//                                 // controller: _timeController,
//                                 //initialValue: _initialValue,
//                                 firstDate: DateTime(2018),
//                                 lastDate: DateTime(2100),
//                                 icon: const Icon(Icons.event),
//                                 dateLabelText: 'Date',
//                                 onChanged: (day) {
//                                   _allReservationsLogic
//                                       .getReservationByDate(day);
//
//                                   print('lkhl ' +
//                                       AllReservationsLogic
//                                           .allFoundReservationsList.length
//                                           .toString());
//                                 }),
//
//                             const SizedBox(
//                               height: 20,
//                             )
//
//                             // ElevatedButton(
//                             //   onPressed: () {
//                             //     if (_formKey.currentState!.saveAndValidate()) {
//                             //       print(_formKey.currentState!.value['email']);
//                             //       print(_formKey.currentState!.value['password']);
//                             //     }
//                             //   },
//                             //   child: const Text('Save'),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: _currentReservationList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           Reservation _reservationInstance =
//                           _currentReservationList[
//                           index]; //rappresenta la singola prenotazione nella lista delle prenotazioni
//                           return Card(
//                             child: ListTile(
//                               title: Text(_reservationInstance.date),
//                               subtitle: Text(_reservationInstance
//                                   .customer.returnNameAndSurname),
//                               trailing: Text('€ ' +
//                                   _reservationInstance.totalCost.toString()),
//                             ),
//                           );
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
