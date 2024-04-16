import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/model/passdata.dart';
import 'package:finalproject/work.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login extends StatefulWidget {
  static const String screenRout = 'loging';
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String parameterValue = "";

  // Set the parameter value in the singleton class

  bool check = true;
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  Future<List<Map<String, dynamic>>> searchDataByEmail(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('dataClient')
        .where('email', isEqualTo: email)
        .get();

    List<Map<String, dynamic>> matchingData = [];

    if (querySnapshot.size > 0) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> userData = documentSnapshot.data();
        matchingData.add(userData);
      }
    }

    return matchingData;
  }

  bool showspiner = false;
  @override
  Widget build(BuildContext context) {
    if (parameterValue != null) {
      ParameterSingleton().setParameterValue(parameterValue);
    } else {
      print("object");
    }

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showspiner,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 121, 119, 119),
                Color.fromARGB(255, 168, 167, 167),
              ])),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  "Hello..\nLog in!  ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: Email,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              label: Text(
                                'Email',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 168, 167, 167),
                                ),
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        TextField(
                          controller: Password,
                          obscureText: true,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.visibility_off),
                              ),
                              label: Text(
                                'Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 168, 167, 167),
                                ),
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color.fromARGB(255, 121, 119, 119),
                                Color.fromARGB(255, 168, 167, 167),
                              ]),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        255, 121, 119, 119),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ],
                            ),
                            child: Center(
                              child: MaterialButton(
                                  onPressed: () async {
                                    setState(() {
                                      showspiner = true;
                                    });

                                    String textFieldemail = Email.text;
                                    String textFieldpassword = Password.text;
                                    try {
                                      final newUser = await _auth
                                          .signInWithEmailAndPassword(
                                              email: textFieldemail,
                                              password: textFieldpassword);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => workpage()),
                                      );
                                      if (Email.text.isNotEmpty) {
                                        setState(() {
                                          parameterValue = Email.text;
                                        });
                                      } else {
                                        parameterValue = " nothing";
                                      }

                                      setState(() {
                                        showspiner = false;
                                      });
                                    } catch (e) {
                                      setState(() {
                                        showspiner = false;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content:
                                                Text('this email not existe'),
                                            actions: [
                                              TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  minWidth: double.infinity,
                                  height: 60,
                                  child: Text(
                                    'Login ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
