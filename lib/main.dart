import 'package:finalproject/model/Cart_Content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'work.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return CartContent();
        },
        child: MaterialApp(
          initialRoute: workpage.screenRout,
          routes: {
            workpage.screenRout: (context) => workpage(),
          },
        ));
  }
}
