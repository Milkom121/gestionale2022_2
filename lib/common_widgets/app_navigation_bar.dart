
import 'package:flutter/material.dart';

import '../pages/all_reservations_page/all_reservations_screen.dart';
import '../pages/customers_page/all_customers_screen.dart';
import '../pages/home_page.dart';




class AppNavigationBar extends StatefulWidget {

  AppNavigationBar(this.actualIndex, {Key? key}) : super(key: key);

  int actualIndex;

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}


class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;

  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Bar',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Restaurant',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Pool',
  //     style: optionStyle,
  //   ),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0 && widget.actualIndex != 0) {
        Navigator.pushNamed(context, HomePage.routeName);
      }



      if (index == 1 && widget.actualIndex != 1 ) {
        Navigator.pushNamed(context, AllReservationsScreen.routeName);
      }

      

      if (index == 2 && widget.actualIndex != 2 ) {
        Navigator.pushNamed(context, AllCustomersScreen.routeName);
      }

      // if (index == 3 && widget.actualIndex != 3 ) {
      //   Navigator.pushNamed(context, AllCustomersScreen2.routeName);
      // }



    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.local_drink),
        //   label: 'Bar',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.restaurant),
        //   label: 'Restaurant',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.beach_access),
        //   label: 'Pool',
        // ),

        // BottomNavigationBarItem(
        //   icon: Icon(Icons.post_add_outlined), //Icons.menu_book_rounded
        //   label: 'Booking',
        // ),

        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded), //
          label: 'Booking',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.people), //
          label: 'Customers',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), //
          label: 'Customers',
        ),


        // BottomNavigationBarItem(
        //     icon: Icon(Icons.supervisor_account_outlined),
        //   label: 'Users'
        // ),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.inventory),
        //   label: 'Inventory'
        // ),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.stacked_bar_chart),
        //     label: 'Analytics'
        // )
      ],
      currentIndex: widget.actualIndex,
      unselectedItemColor: Colors.grey[300],
      selectedItemColor: Theme.of(context).accentColor,
      onTap: _onItemTapped,
    );
  }
}
