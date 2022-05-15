
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestionale2022_2/models/users_types.dart';

import '../../network/authentication.dart';
import '../home_page.dart';
import 'registration_screen.dart';
import 'validator.dart';

///LOGIN SCREEN
// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static String routeName = '/LoginScreen';



  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 60,
              ),
              const SizedBox(
                height: 70,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 35),
                        child: TextFormField(
                          controller: _emailTextController,
                          focusNode: _focusEmail,
                          validator: (value) => Validator.validateEmail(
                            email: value,
                          ),
                          decoration: InputDecoration(
                            hintText: "Email",
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
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 35),
                        child: TextFormField(
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          obscureText: true,
                          validator: (value) => Validator.validatePassword(
                            password: value,
                          ),
                          decoration: InputDecoration(
                            hintText: "Password",
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
                        onPressed: () async {
                          _focusEmail.unfocus();
                          _focusPassword.unfocus();

                          if (_formKey.currentState!.validate()) {
                            User? user =
                                await MyFireAuth.signInUsingEmailPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text,
                              context: context,
                            );

                            if (user != null) {
                             CustomerAuth customer =  CustomerAuth();
                             customer.email = user.email; // potrebbe non essere necesaria ma decideremo poi
                             customer.id = user.uid;
                             Navigator.pushNamed(context, HomePage.routeName);
                            } else {
                              SnackBar snackBar = SnackBar(
                                content: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RegistrationScreen.routeName);
                                    },
                                    child: const  Text(
                                        'Seems your account does not exists yet ;)')),
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        child: const Text('Login'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegistrationScreen.routeName);
                        },
                        child: const Text(
                          'First visit? Register now!',
                        ),
                      ),

                      FloatingActionButton(
                        child: const  Text('HOMEPAGE'),
                        backgroundColor: Colors.red,
                        onPressed: (){Navigator.pushNamed(
                          context, HomePage.routeName);}
                      )
                    ],
                  ))

              //
            ],
          ),
        ),
      ),
    );
  }
}

//Form(
//     key: _formKey,
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 25, right: 35),
//           child: TextFormField(
//             textInputAction: TextInputAction.next,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(
//               hintText: 'Please provide your better email',
//               labelText: 'Email',
//               labelStyle:
//                   TextStyle(fontSize: 18, color: Colors.blue),
//             ),
//             //textInputAction: TextInputAction.next,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please provide correct email';
//               }
//               return null;
//             },
//             onSaved: (value) {
//               _email = value;
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 25, right: 35),
//           child: TextFormField(
//             textInputAction: TextInputAction.next,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               hintText: 'Please create a password',
//               labelText: 'Password',
//               labelStyle:
//                   TextStyle(fontSize: 18, color: Colors.blue),
//             ),
//             //textInputAction: TextInputAction.next,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please provide correct password';
//               }
//               return null;
//             },
//             onSaved: (value) {
//               _password = value;
//             },
//           ),
//         ),
//         const SizedBox(
//           height: 50,
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               textStyle: const TextStyle(fontSize: 18)),
//           onPressed: () async {
//             if (_formKey.currentState!.validate()) {
//               User? user = await FireAuth.signInUsingEmailPassword(
//                 email: _email!,
//                 password: _password!,
//                 context: context,
//               );
//               if (user != null) {
//                 Navigator.of(context).pushNamed(HomePage.routeName);
//               }
//               //Navigator.pushNamed(context, HomePage.routeName);
//             }
//           },
//           child: const Text('Login'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pushNamed(RegistrationScreen.routeName);
//           },
//           child: const Text(
//             'First visit? Register now!',
//           ),
//         ),
//       ],
//     ))
