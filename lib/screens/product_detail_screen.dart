import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  const ProductDetailScreen({Key key}) : super(key: key);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // it gives us product id - we want to get all product data for that id
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                alignment: Alignment.topCenter,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${loadedProduct.title}',
                style: TextStyle(fontSize: 26),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProduct.price}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${loadedProduct.description}')
            ],
          ),
        ),
      ),
    );
  }
}
