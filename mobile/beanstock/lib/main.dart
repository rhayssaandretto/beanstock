import 'package:beanstock/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app.dart';
import 'core/providers/product_provider.dart';
import 'core/providers/store_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider(ApiService())),
    ChangeNotifierProvider(create: (_) => StoreProvider()),
  ], child: const MyApp()));
}
