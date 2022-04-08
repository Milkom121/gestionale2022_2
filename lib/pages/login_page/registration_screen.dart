// import 'package:flutter/material.dart';
//
// class RegistrationScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Form(
//               key: _formKey,
//               child: Column(
//             children: [
//               TextFormField(
//
//               )
//             ],
//           )),
//         ),
//       ),
//     )
//   }
// }
//
//
//
//
//
























































import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'validator.dart';

///REGISTRATION SCREEN
// ignore: must_be_immutable
class RegistrationScreen extends StatelessWidget {
  static String routeName = '/RegistrationScreen';





  //final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 100,
              ),
              const SizedBox(
                height: 30,
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
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
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
                              borderSide: BorderSide(
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
                        onPressed: ()  async {


                        },
                        child: const Text('Register'),
                      ),
                      TextButton(
                        child: const Text(
                          'Already registered? Go to login!',
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                      ),
                    ],
                  ))
            ],
          ),
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
                      ),*/