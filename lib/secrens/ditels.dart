import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/model/viwehome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  Product items;
  Details(this.items);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartContent>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 1.7,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 224, 224, 224),
                  image: DecorationImage(
                    image: AssetImage(widget.items.image),
                  )),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 22,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.favorite,
                          size: 22,
                          color: const Color.fromARGB(255, 121, 119, 119),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 11),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.items.name,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$" + widget.items.price.toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "MODEL CAR IS:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "NAMES",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "A flower, also known as a bloom or blossom, is the reproductive",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            CupertinoIcons.chat_bubble_text,
                            size: 30,
                            color: const Color.fromARGB(255, 121, 119, 119),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            CupertinoIcons.cart_fill,
                            size: 30,
                            color: const Color.fromARGB(255, 121, 119, 119),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 70),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 121, 119, 119),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "BUY NOW",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
