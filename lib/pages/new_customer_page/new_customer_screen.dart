import 'package:flutter/material.dart';
import 'package:gestionale2022_2/pages/customers_page/all_customers_screen.dart';
import 'package:gestionale2022_2/pages/new_customer_page/new_customer_screen_logic.dart';
import 'package:provider/provider.dart';

import '../login_page/validator.dart';

///REGISTRATION SCREEN
// ignore: must_be_immutable
class NewCustomerScreen extends StatefulWidget {
  static String routeName = '/RegistrationScreen';


  NewCustomerScreen({Key? key}) : super(key: key);

   static final _formKey = GlobalKey<FormState>();

  @override
  State<NewCustomerScreen> createState() => _NewCustomerScreenState();
}

class _NewCustomerScreenState extends State<NewCustomerScreen> {
  //final _registerFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();

  final _surnameTextController = TextEditingController();

  final _phoneNumberTextController = TextEditingController();

  final _emailTextController = TextEditingController();

  final _focusName = FocusNode();

  final _focusSurname = FocusNode();

  final _focusPhoneNumber = FocusNode();

  final _focusEmail = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _newCustomerScreenLogicProvider =
        Provider.of<NewCustomerScreenLogic>(context, listen: false);

    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusSurname.unfocus();
        _focusPhoneNumber.unfocus();
        _focusEmail.unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Form(
                key: NewCustomerScreen._formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const Icon(Icons.person),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 35),
                            child: TextFormField(

                              keyboardType: TextInputType.name,
                              controller: _nameTextController,
                              focusNode: _focusName,
                              validator: (value) => Validator.validateName(
                                name: value,
                              ),
                              onSaved: (value) {
                                _newCustomerScreenLogicProvider.setParameters(
                                    'name', value!);
                              },
                              decoration: InputDecoration(
                                icon: const Icon(Icons.person),
                                label: const Text('Name'),
                                //hintText: "Name",
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 35),
                            child: TextFormField(

                              keyboardType: TextInputType.name,
                              controller: _surnameTextController,
                              focusNode: _focusSurname,
                              validator: (value) => Validator.validateName(
                                name: value,
                              ),
                              onSaved: (value) {
                                _newCustomerScreenLogicProvider.setParameters(
                                    'surname', value!);
                              },
                              decoration: InputDecoration(
                                label: const Text('Surname'),
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///capire perchè
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 35),
                      child: TextFormField(

                        keyboardType: TextInputType.number,
                        controller: _phoneNumberTextController,
                        focusNode: _focusPhoneNumber,
                        validator: (value) =>
                            Validator.validatePhoneNumber(phoneNumber: value),
                        onSaved: (value) {
                          _newCustomerScreenLogicProvider.setParameters(
                              'phoneNumber', value!);
                        },
                        decoration: InputDecoration(
                          icon: const Icon(Icons.phone),
                          label: const Text('Phone Number'),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 35),
                      child: TextFormField(

                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(
                          email: value,
                        ),
                        onSaved: (value) {
                          _newCustomerScreenLogicProvider.setParameters(
                              'email', value!);
                        },
                        decoration: InputDecoration(
                          icon: const Icon(Icons.email),
                          label: const Text('Email'),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18)),
                      onPressed: () {
                        NewCustomerScreen._formKey.currentState!.save();
                        _newCustomerScreenLogicProvider.addCustomer();
                        Navigator.pushNamed(context, AllCustomersScreen.routeName);
                      },
                      child: const Text('Register'),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

/*                    Padding(
                        padding: const EdgeInsets.only(left: 25, right: 35),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Please provide your better email',
                            labelText: 'Email',
                            labelStyle:
                            TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                          //textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide correct email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 35),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Please provide your password',
                            labelText: 'Password',
                            labelStyle:
                            TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                          //textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide correct password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                        ),
                      ),
                      */

// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:gestionale2022_2/pages/new_reservation_page/screens/reservation_customer_search.dart';
// import 'package:provider/provider.dart';
//
// import '../new_reservation_page/new_reservation_form_logic.dart';
// import 'new_customer_screen_logic.dart';
//
// //TODO: fare in modo che vengano richiamati i dati dal backend anche  in questa schermata
// //TODO: fare in modo che il customer selezionato venga riportato nella schermata
//
// class NewCustomerScreen extends StatefulWidget {
//   const NewCustomerScreen({
//     Key? key,
//     //required this.onClose
//   }) : super(key: key);
//
//   //final Function() onClose;
//   static const routeName = '/NewReservationScreen';
//
//   @override
//   State<NewCustomerScreen> createState() => _NewCustomerScreenState();
// }
//
// class _NewCustomerScreenState extends State<NewCustomerScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   @override
//   Widget build(BuildContext context) {
//     // final _reservationFormLogic = Provider.of<ReservationFormLogic>(context);//mi collego al file con la logica di questa schermata
//
//     bool _discountVisibility = true;
//     //CustomerDB _customerDB = NewReservationFormLogic.reservationMap['customer'] ;
//     return Consumer<NewCustomerScreenLogic>(
//       builder: (context, _newCustomerScreenLogic, child) => Material(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
//             child: FormBuilder(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ///CUSTOMER
//                     Row(
//                       children: [
//                         Flexible(
//                           child: TextFormField(
//                             key: UniqueKey(),
//                             readOnly: true,
//                             decoration: const InputDecoration(
//                               icon: Icon(Icons.person),
//                               label: Text('Name'),
//                             ),
//                             onTap: () {},
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Flexible(
//                           child: TextFormField(
//                             key: UniqueKey(),
//                             readOnly: true,
//                             decoration: const InputDecoration(
//                               label: Text('Surname'),
//                             ),
//                             onTap: () {},
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     TextFormField(
//                       key: UniqueKey(),
//                       readOnly: true,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.mail),
//                         label: Text('eMail'),
//                       ),
//                       onTap: () {},
//                     ),
//
//                     TextFormField(
//                       key: UniqueKey(),
//                       readOnly: true,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.phone),
//                         label: Text('Phone'),
//                       ),
//                       onTap: () {},
//                     ),
//                     const SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: const Text('Save'),
//                     ),
//                   ],
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
//
