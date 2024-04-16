import 'package:flutter/material.dart';

class introtw extends StatefulWidget {
  const introtw({super.key});

  @override
  State<introtw> createState() => _introtwState();
}

class _introtwState extends State<introtw> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/dilevry3.jpg'))),
        ),
        SizedBox(height: 20), // ترك مسافة بين الصورة والنص
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), // فراغ يمين ويسار
          child: Text(
            'توصيل سريع وموثوق',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10), // ترك مسافة بين العنوان والنص
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), // فراغ يمين ويسار
          child: Text(
            'نحن نقدم خدمة توصيل سريعة وموثوقة لطلباتكم إلى عناوينكم المحددة. للجميع قطع الغيار المتوفر فإننا نهتم بضمان وصولها بأمان وفي أقرب وقت ممكن. قم بإدخال عنوان التسليم الخاص بك واستمتع براحة البال وتوصيل مضمون.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
