import 'package:flutter/material.dart';
//import provider
import 'package:provider/provider.dart';

import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // method 1
    return ChangeNotifierProvider(
      create: (context) => Products(),
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
          ProductDetailScreen.routeName: (context) => ProductDetailScreen()
        },
      ),
    );
  }
}
