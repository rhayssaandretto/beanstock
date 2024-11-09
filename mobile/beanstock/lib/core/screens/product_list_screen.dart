import 'package:beanstock/core/providers/product_provider.dart';
import 'package:beanstock/core/screens/product_form_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/store.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Store? selectedStore;
  List<Store> stores = []; // Initialize with your list of stores

  @override
  void initState() {
    super.initState();
    // Carregar os produtos ao iniciar a página
    Provider.of<ProductProvider>(context, listen: false).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: products.isEmpty
                ? const Center(child: CircularProgressIndicator())
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
                                  child: Icon(Icons
                                      .coffee_outlined)); // Exibe erro caso a imagem não seja carregada
                            },
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            if (product.id != null) {
                              await productProvider.delete(product.id!);
                            }
                          },
                        ),
                        onTap: () {
                          // Navegar para a tela de edição de produto
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductFormPage(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
