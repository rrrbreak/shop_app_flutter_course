import 'package:flutter/material.dart';
import 'product.dart';

// here we want to define a list of products
class Products with ChangeNotifier {
  // 1. list of products based on product model - direct access to this list of items
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'T-Shirt',
      description: 'Pretty white shirt.',
      price: 29.99,
      imageUrl:
          'https://images.pexels.com/photos/4066288/pexels-photo-4066288.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.pexels.com/photos/65676/nanjing-studio-jeans-65676.jpeg',
    ),
    Product(
      id: 'p3',
      title: 'Hat',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://images.pexels.com/photos/1878821/pexels-photo-1878821.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Product(
      id: 'p4',
      title: 'Shoes',
      description: 'New shoes model - check it out!',
      price: 49.99,
      imageUrl:
          'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
  ];

  var _showFavoritesOnly = false;

// 2. Creating getter to get a copy of _items to
  List<Product> get items {
    // Lista w której są elementy które są polajkowane
    // if (_showFavoritesOnly == true) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

// tworzymy liste na podstawie product żeby zapisywać w niej polikowane
  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   // notifyListeners to rebuild the parts that are interested in our product data
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
