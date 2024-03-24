import 'package:flutter/material.dart';

Widget Mydrwelist(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15.0),
    child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
              selected: true,
              leading: Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              title: Text(
                "اميلي الشخصي",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // سماكة النص
                  fontSize: 16, // حجم الخط
                  color: Colors.black, // لون النص
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward,
                color: Colors.grey,
              ),
              onTap: () {}),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 100),
            child: Text(
              "المشتريات",
              textAlign: TextAlign.end,
            ),
          ),
          ListTile(
            selected: true,
            leading: Icon(Icons.shopping_cart, color: Colors.black),
            title: Text(
              "طلبياتي",
              style: TextStyle(
                fontWeight: FontWeight.bold, // سماكة النص
                fontSize: 16, // حجم الخط
                color: Colors.black, // لون النص
              ),
            ),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 100),
            child: Text(
              "البيانات الشخصية",
              textAlign: TextAlign.end,
            ),
          ),
          ListTile(
            selected: true,
            title: Text(
              "عناويني ",
              style: TextStyle(
                fontWeight: FontWeight.bold, // سماكة النص
                fontSize: 16, // حجم الخط
                color: Colors.black, // لون النص
              ),
            ),
            leading: Icon(
              Icons.delivery_dining,
              color: Colors.black,
            ),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 100),
            child: Text(
              " التطبيق",
              textAlign: TextAlign.end,
            ),
          ),
          ListTile(
            selected: true,
            title: Text("حول التطبيق ",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // سماكة النص
                  fontSize: 16, // حجم الخط
                  color: Colors.black, // لون النص
                )),
            leading: Icon(
              Icons.help_center,
              color: Colors.black,
            ),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
          ListTile(
            selected: true,
            title: Text("تفعيل الخدمة",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // سماكة النص
                  fontSize: 16, // حجم الخط
                  color: Colors.black, // لون النص
                )),
            leading: Icon(
              Icons.key,
              color: Colors.black,
            ),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
          ListTile(
            selected: true,
            title: Text("تسجيل الدخول ",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // سماكة النص
                  fontSize: 16, // حجم الخط
                  color: Colors.black, // لون النص
                )),
            leading: Icon(
              Icons.login,
              color: Colors.black,
            ),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
          ListTile(
            selected: true,
            title: Text("تسجيل الخروج ",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // سماكة النص
                  fontSize: 16, // حجم الخط
                  color: Colors.black, // لون النص
                )),
            // leading: Icon(
            //   Icons.logout,
            //   color: Colors.black,
            // ),
            onTap: () {},
            trailing: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ]),
  );
}
