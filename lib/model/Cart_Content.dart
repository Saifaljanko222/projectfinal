import 'package:finalproject/model/viwehome.dart';
import 'package:flutter/material.dart';

class CartContent with ChangeNotifier {
  List selectedProduct = [];
  double price = 0.0;

  bool containsFavorite(Product product) {
    return selectedProduct.contains(product);
  }

  void add(Product product) {
    if (selectedProduct.contains(product)) {
      // Product already exists in the cart, do not add it again
      return;
    }
    selectedProduct.add(product);
    price += product.price.round();
    notifyListeners();
  }

  void remove(Product product) {
    if (selectedProduct.isEmpty) {
      return; // If the selected product list is empty, don't remove anything
    }
    selectedProduct.remove(product);
    price -= product.price.round();

    notifyListeners();
  }

  void incrementQuantity(Product product) {
    product.quantity += 1;
    price += product.price;
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity -= 1;
      price -= product.price;
      notifyListeners();
    }
  }

  void removeSelected() {
    product.removeWhere((product) => product.selected);
  }
}

class favecontent with ChangeNotifier {
  List selectedProduct = [];
  double price = 0.0;
  void add(Product product) {
    if (selectedProduct.contains(product)) {
      // Product already exists in the cart, do not add it again
      return;
    }
    selectedProduct.add(product);
    price += product.price.round();
    notifyListeners();
  }

  void remove(Product product) {
    if (selectedProduct.isEmpty) {
      return; // If the selected product list is empty, don't remove anything
    }
    selectedProduct.remove(product);
    price -= product.price.round();

    notifyListeners();
  }

  void incrementQuantity(Product product) {
    product.quantity += 1;
    price += product.price;
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity -= 1;
      price -= product.price;
      notifyListeners();
    }
  }

  void removeSelected() {
    product.removeWhere((product) => product.selected);
  }
}
