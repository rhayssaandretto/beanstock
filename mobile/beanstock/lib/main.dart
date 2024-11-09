import 'package:beanstock/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app.dart';
import 'core/providers/product_provider.dart';
import 'core/providers/store_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => ApiService()),
      ChangeNotifierProvider(
          create: (context) =>
              ProductProvider(Provider.of<ApiService>(context, listen: false))),
      ChangeNotifierProvider(create: (_) => StoreProvider()),
    ],
    child: const MyApp(),
  ));
}
