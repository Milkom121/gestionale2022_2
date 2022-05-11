import 'user.dart';

class Customer extends MNUser {
  String? phoneNumber;
  // final String id;
  // final String name;
  // final String surname;
  //
  // Customer({
  //   required String id,
  //   required String name,
  //   required String surname,
  //   required String email,
  //   phoneNumber, // named parameter non obbligatorio (in teoria)
  // }) : super(id: id, name: name, surname: surname, email: email);

  Customer._privateConstructor(); ///costruttore privato

  static final Customer _instance = Customer._privateConstructor(); /// instanza di customer che sarà globale in tutta l'app e mi consentirà di accedere ad i dati dello user che ha effettuato l'accesso

  factory Customer() {
    return _instance;
  } /// quandol chiamo questo costruttore "factory" verrà richiamata sempre e solo la medesima instanza di Customer (_instance)


  static Map<String, dynamic> toMap(Customer customer) => <String, dynamic>{
        'id': customer.id,
        'name': customer.name,
        'surname': customer.surname,
        'email': customer.email,
        'phone_number': customer.phoneNumber,
      };

  // static Customer fromMap(Map<String, dynamic> customerMap) => Customer(
  //       id: customerMap['id'],
  //       name: customerMap['name'],
  //       surname: customerMap['surname'],
  //       email: customerMap['email'],
  //       phoneNumber: customerMap['phone_number'],
  //     );
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
