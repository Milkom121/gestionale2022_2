import 'package:flutter/material.dart';
import 'package:gestionale2022_2/models/reservation.dart';

class ReservationViewScreen extends StatelessWidget {
   const ReservationViewScreen({Key? key, required this.reservation, required this.customerCompleteName}) : super(key: key);

  final Reservation reservation;
 final String customerCompleteName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.black,
            onPressed: () {
              ///navigo verso la pagina di modifica dell'oggetto
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DisposableEditScreen(widget.disposableObject)));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                        const SizedBox(height: 10,),
                        Text(reservation.date),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Customer',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                        const SizedBox(height: 10,),
                        Text(customerCompleteName),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
