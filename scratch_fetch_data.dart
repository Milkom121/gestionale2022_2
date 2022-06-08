
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerDB {
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
    required this.phoneNumber,
  });

  factory CustomerDB.fromMap(Map<String, dynamic> json) => CustomerDB(
      id: json["idToken"].toString(),
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      phoneNumber: json["phoneNumber"].toString());
}

Future<List<CustomerDB>> fetchCustomerDB() async {
  final response =
      await http.get(Uri.parse('https://192.168.178.74:5000/api/customers'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    print(parsed);

    return parsed.map<CustomerDB>((json) => CustomerDB.fromMap(json)).toList();
  } else {
    print(response.statusCode);
    throw Exception('Failed to load customers');
  }
}

//https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides(); //TODO: soluzione teporanea, in produzione occorre xsistemare i problemi del certificato SSL
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<CustomerDB>> futureCustomerDB;

  @override
  void initState() {
    super.initState();
    futureCustomerDB = fetchCustomerDB();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: FutureBuilder<List<CustomerDB>>(
          future: futureCustomerDB,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff97FFFF),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].name +
                            ' ' +
                            snapshot.data![index].surname,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(snapshot.data![index].email),
                      Text(snapshot.data![index].phoneNumber),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
