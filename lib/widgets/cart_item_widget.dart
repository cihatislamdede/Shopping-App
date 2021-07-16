import 'package:flutter/material.dart';
import 'package:my_shop_app/prodivders/cart.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final int quantity;
  final double price;

  const CartItemWidget(
      this.id, this.productId, this.title, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32),
            ),
            content: const Text(
              'Do you want to remove\nthe item from the cart?',
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('NO'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('YES'),
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 36,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                    child: Text(
                  '\$$price',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            subtitle: Text('Total: \$${price * quantity}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: Text(
              'x $quantity',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
