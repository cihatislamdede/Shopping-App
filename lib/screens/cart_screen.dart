import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_shop_app/prodivders/cart.dart';
import 'package:my_shop_app/prodivders/orders.dart';
import 'package:my_shop_app/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  cart.clearCart();
                },
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                  size: 30,
                )),
          )
        ],
      ),
      body: cart.itemCount == 0
          ? const Center(
              child: Text(
              'Empty Cart',
              style: TextStyle(fontSize: 32),
            ))
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, i) => CartItemWidget(
                      cart.items.values.toList()[i].id,
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].title,
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].price),
                  itemCount: cart.items.length,
                )),
                const SizedBox(
                  height: 10,
                ),
                SubTotalWidget(cart: cart),
              ],
            ),
    );
  }
}

class SubTotalWidget extends StatelessWidget {
  const SubTotalWidget({
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cart.items.values),
      child: Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Chip(
                label: Text(
                  '\$${cart.totalAmount}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, elevation: 0),
                onPressed: () {
                  Provider.of<Orders>(context, listen: false)
                      .addOrder(cart.items.values.toList(), cart.totalAmount);
                  cart.clearCart();
                },
                child: Text(
                  'ORDER NOW',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
