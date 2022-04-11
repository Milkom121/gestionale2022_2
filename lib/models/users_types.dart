import 'user.dart';

class Customer extends User {
  String? phoneNumber;
  // final String id;
  // final String name;
  // final String surname;
  //
  Customer({
    required String id,
    required String name,
    required String surname,
    required String email,
    phoneNumber, // named parameter non obbligatorio (in teoria)
  }) : super(id: id, name: name, surname: surname, email: email);

  static Map<String, dynamic> toMap(Customer customer) => <String, dynamic>{
        'id': customer.id,
        'name': customer.name,
        'surname': customer.surname,
        'email': customer.email,
        'phone_number': customer.phoneNumber,
      };

  static Customer fromMap(Map<String, dynamic> customerMap) => Customer(
        id: customerMap['id'],
        name: customerMap['name'],
        surname: customerMap['surname'],
        email: customerMap['email'],
        phoneNumber: customerMap['phone_number'],
      );
}












// import 'user.dart';
//
// class Customer extends User {
//   String? phoneNumber;
//
//   // final String id;
//   // final String name;
//   // final String surname;
//   //
//   Customer({
//     required String id,
//     required String name,
//     required String surname,
//     required String email,
//     phoneNumber, // named parameter non obbligatorio (in teoria)
//   }) : super(id: id, name: name, surname: surname, email: email);
//
//   static Map<String, dynamic> toMap(Customer customer) => <String, dynamic>{
//     'id': customer.id,
//     'name': customer.name,
//     'surname': customer.surname,
//     'email': customer.email,
//     'phone_number': customer.phoneNumber,
//   };
//
//   static Customer fromMap(Map<String, dynamic> customerMap) => Customer(
//     id: customerMap['id'],
//     name: customerMap['name'],
//     surname: customerMap['surname'],
//     email: customerMap['email'],
//     phoneNumber: customerMap['phone_number'],
//   );
// }
