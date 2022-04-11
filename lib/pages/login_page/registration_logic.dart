

import 'package:flutter/cupertino.dart';
import 'package:gestionale2022_2/models/users_types.dart';
import 'package:uuid/uuid.dart';

class RegistrationLogic extends ChangeNotifier{

  static final List<Customer> _allCustomers = [];

  List<Customer> get getAllCustomers {
    List<Customer> list = [... _allCustomers];
    return list;
  }



//TODO: modificare il metodo in modo che prenda un customer senza id che gli arriva dalla pagina di registraizone, lo converta in map, aggiunga l'id, riconverta in Customer ed aggiunga alla lista AllCustomers
void addNewCustomer (Customer customer){
  Uuid uuid = const Uuid();
  Customer _newCustomer = customer;
  _newCustomer.id = uuid.v4(); // aggiungo un id unico al Customer 
  _allCustomers.add(customer);
  notifyListeners();
}

}






///metodo per aggiungere un nuovo customer ma in questo caso per l'id devo rendere il parametro di User non final quindi no buono
// void addNewCustomer (Customer customer){
//   Uuid uuid = const Uuid();
//   Customer _newCustomer = customer;
//   _newCustomer.id = uuid.v4(); // aggiungo un id unico al Customer
//   _allCustomers.add(customer);
//   notifyListeners();
// }
