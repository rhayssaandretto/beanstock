import 'package:beanstock/core/models/product.dart';
import 'package:beanstock/core/services/api_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService;

  ProductProvider(this._apiService);

  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchAll() async {
    _products = await _apiService.fetchAll();
    notifyListeners();
  }

  Future<void> create(Product product) async {
    await _apiService.create(product);
    await fetchAll();
  }

  Future<void> update(String id, Product product) async {
    await _apiService.update(id, product);
    await fetchAll();
  }

  Future<void> delete(String id) async {
    await _apiService.delete(id);
    await fetchAll();
  }
}
