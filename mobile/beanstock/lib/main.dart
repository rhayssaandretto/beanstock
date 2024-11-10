import 'package:beanstock/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app.dart';
import 'core/providers/product_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(
        ApiService(),
      ),
      child: const MyApp(),
    ),
  );
}
