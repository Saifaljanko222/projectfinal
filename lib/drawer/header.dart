import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/model/passdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class myheader extends StatefulWidget {
  const myheader({super.key});

  @override
  State<myheader> createState() => _myheaderState();
}

class _myheaderState extends State<myheader> {
  String parameterValue = '';
  bool _isLoggedIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check user login status during app initialization or wherever appropriate
  void checkLoginStatus() {
    User? user = _auth.currentUser;
    setState(() {
      _isLoggedIn = user != null;
    });
  }

  @override
  void initState() {
    super.initState();
    // Get the parameter value from the singleton class
    parameterValue = ParameterSingleton().getParameterValue();
    if (parameterValue.isEmpty) {
      parameterValue = "";
    } else {
      searchDataByEmail(parameterValue);
    }
  }

  List<Map<String, dynamic>> foundData = [];

  Future<void> searchDataByEmail(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('dataClient')
        .where('email', isEqualTo: email)
        .get();

    setState(() {
      foundData = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 107, 110, 112),
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.only(top: 20.0),
        child: foundData.isNotEmpty
            ? ListView.builder(
                itemCount: foundData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> userData = foundData[index];
                  return Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 5),
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(userData["urlImage"]),
                          )),
                      Text(
                        userData['email'],
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],

                    // Add more widgets to display additional fields
                  );
                },
              )
            : Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(""),
                      )),
                  Text(
                    "email name",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ));
  }
}
