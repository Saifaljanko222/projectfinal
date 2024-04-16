import 'package:finalproject/secrens/active.dart';
import 'package:finalproject/secrens/login.dart';
import 'package:finalproject/work.dart';
import 'package:flutter/material.dart';

class welcompage extends StatefulWidget {
  const welcompage({super.key});
  static const String screenRout = 'welcom';

  @override
  State<welcompage> createState() => _homepageState();
}

class _homepageState extends State<welcompage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //width make it big as my
          //mediaQuery make abig as per the secreen
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),

          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/spare2.jpg'))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WERSHA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      'images/llimage.png',
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'استكشف مجموعة واسعة من قطع غيار السيارات واشترِ ما تحتاجه بسهولة وأمان. يوفر التطبيق تجربة موثوقة ومريحة لبيع وشراء قطع الغيار لمختلف أنواع السيارات.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => login()));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minWidth: MediaQuery.of(context).size.width / 2.5,
                        height: 60,
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 168, 167, 167),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 121, 119, 119),
                            Color.fromARGB(255, 168, 167, 167),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => activepage()));
                        },
                        minWidth: MediaQuery.of(context).size.width / 2.5,
                        height: 60,
                        child: Text(
                          'تفعيل الخدمة',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => workpage()),
                    );
                  },
                  child: Text(
                    'الدخول كزائر',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 121, 119, 119),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
