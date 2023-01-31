import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/products_grid.dart';

// enums are really just ways of assigning labels to integers
enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'MyShop',
          ),
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions value) {
                setState(() {
                  if (value == FilterOptions.Favorites) {
                    // favorites items
                    // productsContainer.showFavoritesOnly();
                    _showOnlyFavorites = true;
                  } else {
                    // all items
                    // productsContainer.showAll();
                    _showOnlyFavorites = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show all'),
                  value: FilterOptions.All,
                ),
              ],
              icon: Icon(Icons.more_vert),
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                label: Text(cart.itemCount.toString()),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            )
          ]),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
