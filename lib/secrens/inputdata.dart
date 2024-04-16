import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/secrens/viweprodect.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';

class inputprodect extends StatefulWidget {
  const inputprodect({super.key});
  static const String screenRout = 'register';

  @override
  State<inputprodect> createState() => _inputprodectState();
}

class _inputprodectState extends State<inputprodect> {
  File? _imageFile;
  Uint8List? _image;
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();

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

  CollectionReference pagetwo =
      FirebaseFirestore.instance.collection('prodectfour');
  Future<void> addUser(String imageurl, String name, String price) {
    // Call the user's CollectionReference to add a new user
    Map<String, dynamic> userData = {
      'imageurl': imageurl,
      'name': name,
      'price': price,

      'location': GeoPoint(0, 0), // Set the initial location to (0, 0)
    };
    return pagetwo
        .add(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ModalProgressHUD(
          inAsyncCall: false,
          child: SingleChildScrollView(
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
                              radius: 45, backgroundImage: MemoryImage(_image!))
                          : const CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  "https://thumbs.dreamstime.com/b/businessman-avatar--beard-hairstyle-male-profile-vector-illustration-178545831.jpg"),
                            )),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: name,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_callback),
                        label: Text(
                          ' اسم المنتج',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 121, 119, 119),
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
                    controller: price,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_callback),
                        label: Text(
                          '  سعر المنتج',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 121, 119, 119),
                          ),
                        )),
                  ),
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
                                color: const Color.fromARGB(255, 121, 119, 119),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Center(
                          child: MaterialButton(
                              onPressed: () async {
                                try {
                                  final storageRef =
                                      FirebaseStorage.instance.ref();
                                  final imageRef = storageRef
                                      .child("iclient/${Uuid().v4()}.jpg");
                                  Uint8List imageData =
                                      await _imageFile!.readAsBytes();
                                  await imageRef.putData(imageData);
                                  final imageurl =
                                      await imageRef.getDownloadURL();

                                  String namep = name.text;
                                  String pricep = price.text;
                                  await addUser(imageurl, namep, pricep);

                                  Fluttertoast.showToast(
                                    msg: 'Data added successfully.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  name.clear();
                                  price.clear();
                                } catch (error) {
                                  Fluttertoast.showToast(
                                    msg: 'An error occurred while adding data.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
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
                                color: const Color.fromARGB(255, 121, 119, 119),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Center(
                          child: MaterialButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductList()));
                              },
                              minWidth: double.infinity,
                              height: 60,
                              child: Text(
                                ' viwe االبيانات ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )),
                ),
              ],
            ),
          )),
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
