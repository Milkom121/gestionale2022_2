
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestionale2022_2/pages/customer_detail_view/customer_detail_view_screen_logic.dart';
import 'package:gestionale2022_2/pages/customers_page/all_customers_screen.dart';
import 'package:gestionale2022_2/pages/customers_page/all_customers_screen_logic.dart';
import 'package:gestionale2022_2/pages/new_customer_page/new_customer_screen_logic.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/all_reservations_page/all_reservations_logic.dart';
import 'pages/all_reservations_page/all_reservations_screen.dart';
import 'pages/home_page.dart';
import 'pages/login_page/login_screen.dart';
import 'pages/login_page/registration_screen.dart';
import 'pages/new_reservation_page/new_reservation_form_logic.dart';
import 'pages/new_reservation_page/screens/new_reservation_screen.dart';

// ...


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides(); //TODO: soluzione teporanea, in produzione occorre xsistemare i problemi del certificato SSL

  WidgetsFlutterBinding.ensureInitialized(); /// fondamentale aggiungere questa istruzione per consentire il caricamento dell'app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewCustomerScreenLogic(),
        ),
        ChangeNotifierProvider(
          create: (_) => AllReservationsLogic(),
        ),
        ChangeNotifierProvider(
          create: (_) => AllCustomersScreenLogic(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomerDetailViewScreenLogic(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewCustomerScreenLogic(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewReservationScreenLogic(),
        ),


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
      initialRoute: LoginScreen.routeName,//ReservationScreen.routeName,// LoginScreen.routeName,// HomePage.routeName, //reimpostare LoginScreen.routeName,
      routes: {
        RegistrationScreen.routeName:(ctx) => RegistrationScreen(),
        LoginScreen.routeName:(ctx) => LoginScreen(),
        HomePage.routeName: (ctx) =>  HomePage(),
        NewReservationScreen.routeName: (ctx) => NewReservationScreen(),
        AllReservationsScreen.routeName: (ctx) => AllReservationsScreen(),
        AllCustomersScreen.routeName: (ctx) => AllCustomersScreen(),
       // AllCustomersScreen2.routeName: (ctx) => AllCustomersScreen2(),



      },
    );
  }
}

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
//
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
//                                   _reservationFormLogic.calculateTotalCost();
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
//
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
//                                   _reservationFormLogic.setDiscountToZero();
//                                 } else {
//                                   _discountVisibility = true;
//                                 }
//                                 _reservationFormLogic.addValueToReservation(
//                                     'day_slot',
//                                     value); //salvo il valore nell'apposito campo della map nel file new_reservation_form_logic.dart
//                                 _reservationFormLogic.calculateTotalCost();
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
//                                 //_reservationFormLogic.calculateTotalCost();
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
//                                   //_reservationFormLogic.calculateTotalCost();
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
//                                   //_reservationFormLogic.calculateTotalCost();
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
//                             _reservationFormLogic.calculateTotalCost();
//                             print(ReservationFormLogic.reservationMap);
//
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
//

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
