import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  // total amount of cart
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Order',
                      style: TextStyle(color: Colors.black87),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
