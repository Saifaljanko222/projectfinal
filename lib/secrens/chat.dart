import 'package:flutter/material.dart';

class chating extends StatefulWidget {
  const chating({super.key});

  @override
  State<chating> createState() => _chatingState();
}

class _chatingState extends State<chating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 121, 119, 119),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'خدمة الدعم',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // Perform chat actions
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 2,
              color: const Color.fromARGB(255, 121, 119, 119),
            ))),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    hintText: "اكتب رسالة...",
                    border: InputBorder.none,
                  ),
                )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "ارسال",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 121, 119, 119),
                      ),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
