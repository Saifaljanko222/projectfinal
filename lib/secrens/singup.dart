import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/work.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';

class register extends StatefulWidget {
  final String number;
  const register({required this.number});
  static const String screenRout = 'welcom';

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  File? _imageFile;
  Uint8List? _image;
  String displayedNumber = "";

  @override
  void initState() {
    super.initState();
    displayedNumber = widget.number;
  }

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

  final TextEditingController name_firest = TextEditingController();
  final TextEditingController name_last = TextEditingController();
  final TextEditingController phone_number = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();
  bool check = true;
  bool showspiner = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> uploadImageToFirebase() async {
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference to the image file in Firebase Storage
    final imageRef = storageRef.child("profile_image.jpg");

    // Get the image data from the displayed image
    Uint8List imageData = await _imageFile!.readAsBytes();

    // Upload the image data to Firebase Storage
    await imageRef.putData(imageData);

    // Display a success message or perform any additional actions
    print("Image uploaded successfully!");
  }

  CollectionReference keysuser =
      FirebaseFirestore.instance.collection('dataClient');
  CollectionReference used = FirebaseFirestore.instance.collection('keyisuse');

  Future<void> addUser(
      String imageurl, String name, String phone, String email, String key) {
    // Call the user's CollectionReference to add a new user
    Map<String, dynamic> userData = {
      'urlImage': imageurl,
      'name': name,
      'phone': phone,
      'email': email,
      'key': key,
      'location': GeoPoint(0, 0), // Set the initial location to (0, 0)
    };
    return keysuser
        .add(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> keyused(String key) {
    // Call the user's CollectionReference to add a new user
    return used
        .add({"keyuser": key})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showspiner,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          gradient: LinearGradient(colors: [
                            const Color.fromARGB(255, 121, 119, 119),
                            Color.fromARGB(255, 168, 167, 167),
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 22),
                        child: Text(
                          "Hello..\nSingup!  ",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
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
                                : const CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage(
                                        "https://thumbs.dreamstime.com/b/businessman-avatar--beard-hairstyle-male-profile-vector-illustration-178545831.jpg"),
                                  )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        displayedNumber,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                controller: name_last,
                                expands: false,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.person_4),
                                  labelText: 'لقب العميل',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 121, 119, 119),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: name_firest,
                                expands: false,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.person_2),
                                  labelText: 'اسم العميل',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 121, 119, 119),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: phone_number,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_callback),
                              label: Text(
                                'رقم الهاتف',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 121, 119, 119),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: Email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              label: Text(
                                'الاميل الابكتروني',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 121, 119, 119),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: Password,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password_outlined),
                              label: Text(
                                'رمز الدخول',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 121, 119, 119),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 20,
                      ),
                      BottomAppBar(
                        child: Padding(
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
                                      ////////////////////////////////////insert image to firebase storge

                                      try {
                                        if (name_firest.text.isEmpty ||
                                            name_last.text.isEmpty ||
                                            phone_number.text.isEmpty ||
                                            Email.text.isEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(
                                                    "Please fill out all fields"),
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
                                          return; // Stop further execution if form is not valid
                                        }
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
                                          return; // Stop further execution if image is not selected
                                        }
                                        final storageRef =
                                            FirebaseStorage.instance.ref();
                                        final imageRef = storageRef.child(
                                            "iclient/${Uuid().v4()}.jpg");
                                        Uint8List imageData =
                                            await _imageFile!.readAsBytes();
                                        await imageRef.putData(imageData);
                                        //////////////////////////////////////////////////////////////////
                                        final imageurl =
                                            await imageRef.getDownloadURL();
                                        String nameClient = name_firest.text +
                                            "" +
                                            name_last.text;
                                        String phone = phone_number.text;
                                        String email = Email.text;
                                        String pasword = Password.text;
                                        print("Image uploaded successfully!");
                                        print(imageurl);
                                        addUser(imageurl, nameClient, phone,
                                            email, displayedNumber);
                                        keyused(displayedNumber);
                                        final newUser = await _auth
                                            .createUserWithEmailAndPassword(
                                                email: email,
                                                password: pasword);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    workpage()));
                                        setState(() {
                                          showspiner = false;
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
                                        setState(() {
                                          showspiner = false;
                                        });
                                      }
                                    },
                                    minWidth: double.infinity,
                                    height: 60,
                                    child: Text(
                                      ' حفظ االبيانات ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '  تكملة البيانات بي Google ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
