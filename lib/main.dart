import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:flutter_complete_guide/screens/user_product_screen.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
//import provider
import 'package:provider/provider.dart';

import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap providers with MultiProvider
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
        )
      ],

      // method 2 - if value doesnt depend on a context
      // return ChangeNotifierProvider.value(value: Products());
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        title: 'MyShop',
        theme: ThemeData(
          appBarTheme: AppBarTheme(foregroundColor: Colors.white),
          fontFamily: 'Lato',
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
            secondary: Colors.grey.shade300,
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
