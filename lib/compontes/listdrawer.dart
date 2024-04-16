import 'package:finalproject/secrens/active.dart';
import 'package:finalproject/secrens/address.dart';
import 'package:finalproject/secrens/login.dart';
import 'package:finalproject/secrens/profilr.dart';
import 'package:finalproject/welcom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mydrwelist extends StatefulWidget {
  const Mydrwelist({super.key});

  @override
  State<Mydrwelist> createState() => _MydrwelistState();
}

class _MydrwelistState extends State<Mydrwelist> {
  bool _isLoggedIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check user login status during app initialization or wherever appropriate
  void checkLoginStatus() {
    User? user = _auth.currentUser;
    setState(() {
      _isLoggedIn = user != null;
    });
  }

  void _logoutUser(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      welcompage.screenRout,
      (Route<dynamic> route) => false,
    );
  }

  // Call the function to check the login status

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
                selected: true,
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "اميلي الشخصي",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // سماكة النص
                    fontSize: 16, // حجم الخط
                    color: Colors.black, // لون النص
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => profile()));
                }),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 100),
              child: Text(
                "المشتريات",
                textAlign: TextAlign.end,
              ),
            ),
            ListTile(
              selected: true,
              leading: Icon(Icons.shopping_cart, color: Colors.black),
              title: Text(
                "طلبياتي",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // سماكة النص
                  fontSize: 16, // حجم الخط
                  color: Colors.black, // لون النص
                ),
              ),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 100),
              child: Text(
                "البيانات الشخصية",
                textAlign: TextAlign.end,
              ),
            ),
            ListTile(
              selected: true,
              title: Text(
                "عناويني ",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // سماكة النص
                  fontSize: 16, // حجم الخط
                  color: Colors.black, // لون النص
                ),
              ),
              leading: Icon(
                Icons.delivery_dining,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => address()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 100),
              child: Text(
                " التطبيق",
                textAlign: TextAlign.end,
              ),
            ),
            ListTile(
              selected: true,
              title: Text("حول التطبيق ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // سماكة النص
                    fontSize: 16, // حجم الخط
                    color: Colors.black, // لون النص
                  )),
              leading: Icon(
                Icons.help_center,
                color: Colors.black,
              ),
              onTap: () {},
            ),
            if (_isLoggedIn == true)
              ListTile(
                selected: true,
                title: Text("تسجيل خروج ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // سماكة النص
                      fontSize: 16, // حجم الخط
                      color: Colors.black, // لون النص
                    )),
                leading: Icon(
                  Icons.login,
                  color: Colors.black,
                ),
                onTap: () {
                  _logoutUser(context);
                },
              )
            else
              ListTile(
                selected: true,
                title: Text("تسجيل دخول ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // سماكة النص
                      fontSize: 16, // حجم الخط
                      color: Colors.black, // لون النص
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
                trailing: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            if (_isLoggedIn == false)
              ListTile(
                selected: true,
                title: Text(" تفعيل الخدمة ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // سماكة النص
                      fontSize: 16, // حجم الخط
                      color: Colors.black, // لون النص
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => activepage()));
                },
                trailing: Icon(
                  Icons.key,
                  color: Colors.black,
                ),
              ),
          ]),
    );
  }
}
