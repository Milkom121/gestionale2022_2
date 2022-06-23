import 'user.dart';


class CustomerDB extends DBUser {

  final String phoneNumber;
  final String id;
  final String name;
  final String surname;
  final String email;

  CustomerDB({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber, // named parameter non obbligatorio (in teoria)
  }) : super(id: id, name: name, surname: surname, email: email);


  String get returnNameAndSurname {
    String _string = name + " " + surname;
    return _string;
  }


static Map<String, dynamic> toMap(CustomerDB customer) => <String, dynamic>{
      'id': customer.id,
      'name': customer.name,
      'surname': customer.surname,
      'email': customer.email,
      'phone_number': customer.phoneNumber,
    };


  factory CustomerDB.fromMap(Map<String, dynamic> map) => CustomerDB(
      id: map["_id"]['\$oid'].toString(),
      name: map["name"],
      surname: map["surname"],
      email: map["email"],
      phoneNumber: map["phoneNumber"].toString());

}






class OwnerAuth extends AuthUser {
  //String? phoneNumber;
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

  OwnerAuth._privateConstructor(); ///costruttore privato

  static final OwnerAuth _instance = OwnerAuth._privateConstructor(); /// instanza di customer che sarà globale in tutta l'app e mi consentirà di accedere ad i dati dello user che ha effettuato l'accesso

  factory OwnerAuth() {
    return _instance;
  } /// quandol chiamo questo costruttore "factory" verrà richiamata sempre e solo la medesima instanza di Customer (_instance)
  // static Map<String, dynamic> toMap(CustomerFirebase customer) => <String, dynamic>{
  //       'id': customer.id,
  //       'name': customer.name,
  //       'surname': customer.surname,
  //       'email': customer.email,
  //       'phone_number': customer.phoneNumber,
  //     };

  //TODO: sistemare quanto segue
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
