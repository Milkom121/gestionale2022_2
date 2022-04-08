

import 'package:flutter/material.dart';

import '../common_widgets/app_navigation_bar.dart';



class HomePage extends StatelessWidget {

  static const routeName = '/HomePage';

  final int screenIndex = 0;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.black,
            onPressed: (){

              Navigator.pushNamed(context, 'BookingStepper.routeName');
              //inviare posizione gps ad amici
            }
            ,
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
            children: [
              const ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
               ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
                onTap:(){
                  //Navigator.pushNamed(context, CustomerRegistrationScreen.routeName);
                  },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Settings'),
                onTap: () async {

                },
              ),
            ],
          ),),

      bottomNavigationBar: AppNavigationBar(screenIndex),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/mainsummer_logo.png'),
              ),),
            // ListView.builder(
            //     itemCount: promo.promoItems.length  ,
            //     itemBuilder:(context, index) => PromoItem(title, imageUrl, price, description))
          ],
        ),
      ),
    );
  }
}

