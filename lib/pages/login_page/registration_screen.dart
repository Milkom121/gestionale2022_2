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
  final _surnameTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _rePasswordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusSurname = FocusNode();
  final _focusPhoneNumber = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusRePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusSurname.unfocus();
        _focusPhoneNumber.unfocus();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         // const Icon(Icons.person),

                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 35),
                              child: TextFormField(
                                controller: _nameTextController,
                                focusNode: _focusName,
                                validator: (value) => Validator.validateName(
                                  name: value,
                                ),
                                onSaved: (value){},
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
                              padding:
                                  const EdgeInsets.only(left: 25, right: 35),
                              child: TextFormField(
                                controller: _surnameTextController,
                                focusNode: _focusSurname,
                                validator: (value) => Validator.validateName(
                                  name: value,
                                ),
                                onSaved: (value){},
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
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 35),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneNumberTextController,
                          focusNode: _focusPhoneNumber,
                          validator: (value) =>
                              Validator.validatePhoneNumber(phoneNumber: value),
                          onSaved: (value){},
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
                          controller: _emailTextController,
                          focusNode: _focusEmail,
                          validator: (value) => Validator.validateEmail(
                            email: value,
                          ),
                          onSaved: (value){},
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
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 35),
                        child: TextFormField(
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          obscureText: true,
                          validator: (value) => Validator.validatePassword(
                            password: value,
                          ),
                          onSaved: (value){},
                          decoration: InputDecoration(
                            icon: const Icon(Icons.password),
                            label: const Text('Password'),
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
                          controller: _rePasswordTextController,
                          focusNode: _focusRePassword,
                          obscureText: true,
                          validator: (value) {
                            if (_rePasswordTextController !=
                                _passwordTextController) {
                              return 'Password doesn\'t match!';
                            }
                          },

                          decoration: InputDecoration(
                            icon: const Icon(Icons.password),
                            label: const Text('Re-Password'),
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
                        onPressed: () async {},
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
