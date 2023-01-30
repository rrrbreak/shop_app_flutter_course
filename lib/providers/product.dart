// how product should look like in this app so that we can build products based on this definition
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    // true zmienia na false
    // false zmienia na true
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
