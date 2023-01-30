import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);

// creating listener

  @override
  Widget build(BuildContext context) {
    // this sets up a direct communication channel behind the scenes allows us to set up a connection to one of the provided classes
    // this gives us access to the product object
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      // długość listy z produktami
      itemCount: products.length,
      // itemBuilder return the widget we will see on the screen
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
            // id: products[index].id,
            // imageUrl: products[index].imageUrl,
            // title: products[index].title,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // gridDelegate allows us to define how the grid generally should be structured, so how many columns it should have
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
