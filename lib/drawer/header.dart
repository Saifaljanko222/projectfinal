import 'package:flutter/material.dart';

class myheader extends StatefulWidget {
  const myheader({super.key});

  @override
  State<myheader> createState() => _myheaderState();
}

class _myheaderState extends State<myheader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 107, 110, 112),
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("images/saif.jpg"),
              )),
        )
      ]),
    );
  }
}
