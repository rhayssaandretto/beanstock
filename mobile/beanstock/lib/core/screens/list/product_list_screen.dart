import 'package:beanstock/core/constants.dart';
import 'package:beanstock/core/providers/product_provider.dart';
import 'package:beanstock/core/screens/forms/product_form_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/store.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Store? selectedStore;
  List<Store> stores = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Product List", style: TextStyle(color: primaryBrownColor)),
      ),
      backgroundColor: lightBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Está tudo muito vazio por aqui... Adicione um produto! ƪ(˘⌣˘)ʃ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text("R\$${product.price.toString()}"),
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrl,
                            fit: BoxFit.cover,
                            errorWidget: (BuildContext context, String url,
                                dynamic error) {
                              return const Center(
                                  child: Icon(Icons.coffee_outlined));
                            },
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: activeYellowColor,
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductFormPage(product: product),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              color: activeYellowColor,
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                if (product.id != null) {
                                  await productProvider.delete(product.id!);
                                  _showSnackBar(
                                      context, "Produto deletado com sucesso!");
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
