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
    _products = (await _apiService.create(product)) as List<Product>;
    await fetchAll();
    notifyListeners();
  }

  Future<void> update(Product product) async {
    _products = (await _apiService.update(product)) as List<Product>;
    await fetchAll();
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await _apiService.delete(id);
    notifyListeners();
  }
}
