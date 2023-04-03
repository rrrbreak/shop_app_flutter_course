import 'dart:io';

import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // converting data info json

// here we want to define a list of products
class Products with ChangeNotifier {
  // 1. list of products based on product model - direct access to this list of items
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'T-Shirt',
    //   description: 'Pretty white shirt.',
    //   price: 29.99,
    //   imageUrl:
    //       'https://images.pexels.com/photos/4066288/pexels-photo-4066288.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://images.pexels.com/photos/65676/nanjing-studio-jeans-65676.jpeg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Hat',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://images.pexels.com/photos/1878821/pexels-photo-1878821.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Shoes',
    //   description: 'New shoes model - check it out!',
    //   price: 49.99,
    //   imageUrl:
    //       'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    // ),
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

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://shop-app-max-course-default-rtdb.europe-west1.firebasedatabase.app//products.json');
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      // Transform fetched data
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            isFavorite: productData['isFavorite'],
            imageUrl: productData['imageUrl'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    // sending HTTP request

    final url = Uri.parse(
        'https://shop-app-max-course-default-rtdb.europe-west1.firebasedatabase.app//products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      // _items.add(value);
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      // _items.add(newProduct);
      // at the beggining of the list
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((product) => product.id == id);
    if (prodIndex >= 0) {
      // updating data via PATCH requests
      final url = Uri.parse(
          'https://shop-app-max-course-default-rtdb.europe-west1.firebasedatabase.app//products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://shop-app-max-course-default-rtdb.europe-west1.firebasedatabase.app//products/$id.json');
// index of product we wanna remove
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    // _items.removeWhere((product) => product.id == id);

    // jak się nie uda usunąć, to chcemy przywrócić ten element do listy, żeby tam ciągle był
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
