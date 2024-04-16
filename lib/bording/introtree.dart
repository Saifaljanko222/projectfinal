import 'package:flutter/material.dart';

class introtr extends StatefulWidget {
  const introtr({super.key});

  @override
  State<introtr> createState() => _introtrState();
}

class _introtrState extends State<introtr> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/chating3.png'))),
        ),
        SizedBox(height: 20), // ترك مسافة بين الصورة والنص
        Text(
          'استمتع بالتواصل والتفاعل',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10), // ترك مسافة بين العنوان والنص
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'مرحبًا! نحن نسعد بتوفير خدمة الدعم عبر الدردشة. إذا كان لديك أي أسئلة أو استفسارات أو تحتاج إلى مساعدة في استخدام تطبيقنا، فلا تتردد في الاتصال بنا عبر خدمة الدردشة ',
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
