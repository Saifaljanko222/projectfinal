import 'dart:io';

import 'package:finalproject/bording/intro.dart';
import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/secrens/login.dart';
import 'package:finalproject/work.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyAA2Va2TZOJBeiAMFxDs3Aky36vNmGcl34',
            appId: '1:392551466704:android:6d4f036ab9d3001d61c0d5',
            messagingSenderId: '392551466704',
            projectId: 'finalproject-6e357',
            storageBucket: "finalproject-6e357.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> checkFirstTime() async {
      if (isFirstTime) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstTime', false);
        Navigator.pushReplacementNamed(context, intro.screenRout);
      } else {
        Navigator.pushReplacementNamed(context, workpage.screenRout);
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartContent>(
          create: (context) => CartContent(),
        ),
        ChangeNotifierProvider<favecontent>(
          create: (context) => favecontent(),
        ),
      ],
      child: MaterialApp(
        initialRoute: intro.screenRout,
        routes: {
          intro.screenRout: (context) => intro(),
          login.screenRout: (context) => login(),
        },
      ),
    );
  }
}
