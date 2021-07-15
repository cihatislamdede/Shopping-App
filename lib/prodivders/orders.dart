import 'package:flutter/material.dart';
import 'package:my_shop_app/prodivders/cart.dart';
import 'package:uuid/uuid.dart';

class OrderItem {
  late final String id;
  late final double amount;
  late final List<CartItem> products;
  late final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: const Uuid().v1(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now()),
    );
    notifyListeners();
  }
}
