import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/secrens/singup.dart';
import 'package:flutter/material.dart';

class activepage extends StatefulWidget {
  const activepage({super.key});

  @override
  State<activepage> createState() => _activepageState();
}

class _activepageState extends State<activepage> {
  final TextEditingController controllerKEY = TextEditingController();

  List<QueryDocumentSnapshot> data = [];

  getdata() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('keysuser').get();
    data.addAll(querySnapshot.docs);

    setState(() {});
  }

  bool containsFruit = false;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 121, 119, 119),
            Color.fromARGB(255, 168, 167, 167),
          ])),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 45),
            child: Text(
              "Hello..\n active app  ",
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 168, 167, 167),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                  child: TextField(
                    controller: controllerKEY,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.paste),
                        ),
                        hintText: 'Enter your keys active',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400])),
                  ),
                ),
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
                          color: Color.fromARGB(255, 168, 167, 167),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Center(
                    child: MaterialButton(
                        onPressed: () {
                          // No documents matching the search query found
                          String textFieldValue = controllerKEY.text;
                          FirebaseFirestore.instance
                              .collection('keyisuse')
                              .where("keyuser", isEqualTo: textFieldValue)
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            if (querySnapshot.docs.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('that key is used before '),
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
                            } else {
                              FirebaseFirestore.instance
                                  .collection('keysuser')
                                  .where("key", isEqualTo: textFieldValue)
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                if (querySnapshot.docs.isNotEmpty) {
                                  print("serching true");

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => register(
                                              number: textFieldValue)));
                                  // }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: Text('key active not true:'),
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
                                  print('No matching documents found.');
                                }
                              });
                            }
                          });
                        },
                        minWidth: double.infinity,
                        height: 60,
                        child: Text(
                          'ACTIVE APP',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
