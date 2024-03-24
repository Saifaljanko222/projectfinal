import 'package:finalproject/model/viwehome.dart';
import 'package:flutter/material.dart';

class CartContent with ChangeNotifier {
  List selectedProduct = [];
  double price = 0.0;
  void add(Product product) {
    selectedProduct.add(product);
    price += product.price.round();
    notifyListeners();
  }

  void remove(Product product) {
    selectedProduct.remove(product);
    price -= product.price.round();

    notifyListeners();
  }
}
