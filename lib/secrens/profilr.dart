import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/model/passdata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String parameterValue = '';

  @override
  void initState() {
    super.initState();
    // Get the parameter value from the singleton class
    parameterValue = ParameterSingleton().getParameterValue();
    searchDataByEmail(parameterValue);
  }

  bool showspiner = false;
  File? _imageFile;
  final TextEditingController phone_number = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController nameClient = TextEditingController();
  Uint8List? _image;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _image = File(pickedFile.path).readAsBytesSync();
      });
      Navigator.of(context).pop();
    }
  }

  Future _cameimage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _image = File(pickedFile.path).readAsBytesSync();
      });
      Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspiner,
        child: Center(
          child: foundData.isNotEmpty
              ? ListView.builder(
                  itemCount: foundData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> userData = foundData[index];
                    return Column(
                      children: [
                        Text('Email :$parameterValue'),
                        ElevatedButtonTheme(
                          data: ElevatedButtonThemeData(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(8), // تعديل حجم الزر
                              shape: CircleBorder(),
                              side: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 168, 167, 167),
                              ), // إضافة إطار ملون
                              minimumSize: Size(0, 0), // إعطاء الزر شكل دائري
                            ),
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                show(context);
                              },
                              child: _imageFile != null
                                  ? CircleAvatar(
                                      radius: 45,
                                      backgroundImage: MemoryImage(_image!))
                                  : CircleAvatar(
                                      radius: 45,
                                      backgroundImage:
                                          NetworkImage(userData["urlImage"]),
                                    )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: nameClient,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                label: Text(
                                  userData['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 121, 119, 119),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: phone_number,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                label: Text(
                                  userData['phone'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 121, 119, 119),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                  onPressed: () async {
                                    // setState(() {
                                    //   showspiner = true;
                                    // });
                                    try {
                                      if (nameClient.text.isEmpty ||
                                          phone_number.text.isEmpty ||
                                          Email.text.isEmpty) {}
                                      if (_imageFile == null) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  "Please select an image"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        setState(() {
                                          showspiner = false;
                                        });
                                        return;
                                        // Stop further execution if image is not selected
                                      }
                                      final storageRef =
                                          FirebaseStorage.instance.ref();
                                      final imageRef = storageRef
                                          .child("iclient/${Uuid().v4()}.jpg");
                                      Uint8List imageData =
                                          await _imageFile!.readAsBytes();
                                      await imageRef.putData(imageData);
                                      //////////////////////////////////////////////////////////////////
                                      final imageurl =
                                          await imageRef.getDownloadURL();

                                      print("Image uploaded successfully!");
                                      print(imageurl);
                                      QuerySnapshot<Map<String, dynamic>>
                                          querySnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('dataClient')
                                              .where('email',
                                                  isEqualTo: parameterValue)
                                              .get();

                                      List<Map<String, dynamic>> matchingData =
                                          [];

                                      if (querySnapshot.size > 0) {
                                        for (QueryDocumentSnapshot<
                                                Map<String,
                                                    dynamic>> documentSnapshot
                                            in querySnapshot.docs) {
                                          Map<String, dynamic> userData =
                                              documentSnapshot.data();
                                          matchingData.add(userData);

                                          // Update fields in the userData map
                                          userData['urlImage'] = imageurl;
                                          userData['name'] = nameClient.text;
                                          userData['phone'] = phone_number.text;

                                          // Update the document in Firestore
                                          try {
                                            await documentSnapshot.reference
                                                .update(userData);
                                            print(
                                                'Document updated successfully: ${documentSnapshot.id}');
                                            setState(() {
                                              showspiner = false;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("true"),
                                                  content: Text(
                                                      " updata data client successfully"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("OK"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } catch (e) {
                                            print(
                                                'Error  document: ${documentSnapshot.id}, Error: $e');
                                            setState(() {
                                              showspiner = false;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text(
                                                      "Error uploading image: $e"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("OK"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        }
                                      }

                                      // Update the foundData list with the modified userData
                                      setState(() {
                                        foundData = matchingData;
                                      });
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text(
                                                "Error uploading image: $e"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    setState(() {
                                      showspiner = false;
                                    });
                                  },
                                  minWidth: double.infinity,
                                  height: 60,
                                  child: Text(
                                    'updata data APP',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                        )
                      ],

                      // Add more widgets to display additional fields
                    );
                  },
                )
              : Text('No data found for email:'),
        ),
      ),
    );
  }

  void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (Builder) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _pickImage(),
                      child: const SizedBox(
                          child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                            color: const Color.fromARGB(255, 121, 119, 119),
                          ),
                          Text(
                            "معرض الصور",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 121, 119, 119),
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _cameimage();
                      },
                      child: const SizedBox(
                          child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                            color: const Color.fromARGB(255, 121, 119, 119),
                          ),
                          Text(
                            " كاميرا",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 121, 119, 119),
                            ),
                          )
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
