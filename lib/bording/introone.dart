import 'package:flutter/material.dart';

class onein extends StatefulWidget {
  const onein({super.key});

  @override
  State<onein> createState() => _oneinState();
}

class _oneinState extends State<onein> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/spare.jpg'))),
        ),
        SizedBox(height: 20), // ترك مسافة بين الصورة والنص
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), // فراغ يمين ويسار
          child: Text(
            'قطع غيار سيارات عالية الجودة',
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
            'نحن متخصصون في توفير قطع غيار عالية الجودة للسيارات. سواء كنت بحاجة إلى قطع غيار للمحرك، الفرامل، الإضاءة، نظام التعليق أو أي جزء آخر في سيارتك، فإننا نوفر لك أفضل المنتجات. نحن نعمل مع موردين موثوقين ومصنعين معتمدين لضمان حصولك على قطع الغيار الأصلية والموثوقة. تسوق الآن واحصل على قطع الغيار التي تحتاجها للحفاظ على سيارتك في حالة ممتازة.',
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
