import 'package:flutter/material.dart';
import 'package:my_shop_app/prodivders/products.dart';
import 'package:my_shop_app/screens/add_product_screen.dart';
import 'package:my_shop_app/widgets/app_drawer.dart';
import 'package:my_shop_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.5,
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddProductScreen.routeName);
          },
          icon: const Icon(Icons.add),
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                  productsData.items[index].id,
                  productsData.items[index].title,
                  productsData.items[index].imageUrl),
              const Divider(
                height: 10,
              ),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
