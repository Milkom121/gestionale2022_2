abstract class DBUser {
  String? name;
  String? surname;
  String? email;
  String? id;

  DBUser(
      {required this.email,
      required this.surname,
      required this.id,
      required this.name});
}

abstract class AuthUser {
  String? name;
  String? surname;
  String? email;
  String? id;

  AuthUser();
}
