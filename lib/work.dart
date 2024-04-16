import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/secrens/floatbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'secrens/cart.dart';
import 'secrens/favroite.dart';
import 'secrens/home.dart';
import 'secrens/serch.dart';

class workpage extends StatefulWidget {
  const workpage({super.key});
  static const String screenRout = 'welcom';

  @override
  State<workpage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<workpage> {
  int _currentIndex = 0;
  bool _isPressed = false;

  void _togglePressed() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  final List<Widget> screens = [
    HomeScreen(),
    Searching(),
    FavoritesScreen(),
    cart(),
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartContent>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 30,
        // // selectedItemColor: Color.fromARGB(255, 57, 57, 57),
        // unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color:
                  _isPressed ? Colors.white : Color.fromARGB(255, 57, 57, 57),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_sharp,
              color:
                  _isPressed ? Colors.white : Color.fromARGB(255, 57, 57, 57),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _isPressed ? Colors.grey : Color.fromARGB(255, 57, 57, 57),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              backgroundColor: Colors.red,
              label: Text(cart.selectedProduct.length.toString()),
              largeSize: 20,
              child: Icon(
                Icons.shopping_cart,
                color:
                    _isPressed ? Colors.white : Color.fromARGB(255, 57, 57, 57),
              ),
            ),
            label: "",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => floatB()));
        },
        backgroundColor: Color.fromARGB(255, 88, 87, 87),
        child: Icon(
          Icons.home_max,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
