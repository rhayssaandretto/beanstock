import 'package:beanstock/core/models/store.dart';

class Product {
  String? id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<Store> stores;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stores,
  });
}
