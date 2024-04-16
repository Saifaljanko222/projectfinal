import 'package:finalproject/bording/introone.dart';
import 'package:finalproject/bording/introtree.dart';
import 'package:finalproject/bording/introtwo.dart';
import 'package:finalproject/welcom.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class intro extends StatefulWidget {
  const intro({super.key});
  static const String screenRout = 'welcom';

  @override
  State<intro> createState() => _introState();
}

class _introState extends State<intro> {
  PageController _controller = PageController();
  bool onlast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onlast = (index == 2);
            });
          },
          children: [
            onein(),
            introtw(),
            introtr(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      "skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SmoothPageIndicator(controller: _controller, count: 3),
                onlast
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return welcompage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          "next",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
              ],
            ))
      ]),
    );
  }
}
