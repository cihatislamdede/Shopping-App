import 'package:flutter/material.dart';
import 'package:my_shop_app/dummy_data.dart';
import 'package:my_shop_app/prodivders/product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = dummyData;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoritesItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    //_items.add(value);
    notifyListeners();
  }
}
