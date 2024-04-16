import 'package:finalproject/GMCCARS/GMC1.dart';
import 'package:finalproject/GMCCARS/GMC2.dart';
import 'package:finalproject/GMCCARS/gmc3.dart';
import 'package:finalproject/GMCCARS/gmc4.dart';
import 'package:finalproject/GMCCARS/gmc5.dart';
import 'package:finalproject/cars/FORD.dart';
import 'package:finalproject/cars/GMS.dart';
import 'package:finalproject/cars/JEEP.dart';

//logo
var Listimage = [
  "images/GMC-Emblem.png",
  "images/download.png",
  "images/ford-vector-logo-small.jpg"
];
var listpage = [GMCPAGE(), FORDPAGE(), JEEPPAGE()];

//car1
var gmccar = [
  "images/gmc1.png",
  "images/gmc2.png",
  "images/gmc3.png",
  "images/gmc4.png",
  "images/gmc1.png"
];
var gmcpage = [GMC1(), GMC2(), GMC3(), GMC4(), GMC5()];

class Product {
  final String name;
  final double price;
  final String image;
  int quantity;
  bool selected;

  Product(this.name, this.price, this.image,
      {this.quantity = 1, this.selected = false});
}

List<List<Product>> productall = [
  [
    Product("Ball joint", 888, "images/png-clipartpart.png"),
    Product("Ball joint", 12, "images/png-clipartpart.png"),
    Product(
      "منتج 2",
      222,
      "images/pngparts.png",
    ),
    Product(
      "منتج 2",
      00,
      "images/png-transparent.png",
    ),
  ],
  [
    Product("Ball joint", 2, "images/png-clipartpart.png"),
    Product("Ball joint", 3, "images/png-clipartpart.png"),
    Product("Ball joint", 44, "images/png-clipartpart.png"),
  ],
  [
    Product("Ball joint", 54, "images/png-clipartpart.png"),
    Product("Ball joint", 6, "images/png-clipartpart.png"),
    Product("Ball joint", 1, "images/png-clipartpart.png"),
  ],
  [
    Product("Ball joint", 0, "images/png-clipartpart.png"),
    Product("Ball joint", 8, "images/png-clipartpart.png"),
    Product("Ball joint", 5, "images/png-clipartpart.png"),
  ]
];
//prodect to all cars to buy

List<Product> product = [
  Product("Ball joint", 33, "images/png-clipartpart.png"),
  Product("Ball joint", 33, "images/png-clipartpart.png"),
  Product("Ball joint", 33, "images/png-clipartpart.png"),
  Product(
    "منتج 2",
    200,
    "images/png-transparent.png",
  ),
  Product(
    "منتج 2",
    200,
    "images/png-transparent.png",
  ),
  Product("Ball joint", 33, "images/png-clipartpart.png"),
  Product(
    "منتج 2",
    200,
    "images/png-transparent.png",
  ),
  Product(
    "منتج 2",
    200,
    "images/png-transparent.png",
  ),
];

List<List<Product>> products = [
  //قسم قطع الغيار لي جي ام سي
  [
    Product(
      "منتج 1",
      100,
      "images/png-clipartpart.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/pngparts.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
  ],
  //
  [
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 4",
      400,
      "images/gmc3.png",
    ),
  ],
  //
  [
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
  ],
  //
  [
    Product(
      "منتج 5",
      500,
      "images/gmc3.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
  ],

  //
  [
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 2",
      200,
      "images/png-transparent.png",
    ),
    Product(
      "منتج 8",
      800,
      "images/gmc3.png",
    ),
  ],
];
