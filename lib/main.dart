import 'package:flutter/material.dart';
import 'package:my_shop_app/prodivders/cart.dart';
import 'package:my_shop_app/prodivders/orders.dart';
import 'package:my_shop_app/prodivders/products.dart';
import 'package:my_shop_app/screens/cart_screen.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';
import 'package:my_shop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            accentColor: Colors.deepOrange,
            fontFamily: 'RNSSanz'),
        home: MyHomePage(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductsOverviewScreen(),
    );
  }
}
