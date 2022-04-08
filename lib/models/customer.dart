class Customer {
  final String name;
  final String surname;
  final String email;

  Customer({required this.name, required this.surname, required this.email});

  static Map<String, dynamic> customerToMap(Customer customer) => <String, dynamic>{
        'name': customer.name,
        'surname': customer.surname,
        'email': customer.email,
      };

  static Customer mapToCustomer(Map<String, dynamic> customerMap) => Customer(
        name: customerMap['name'],
        surname: customerMap['surname'],
        email: customerMap['email'],
      );
}
