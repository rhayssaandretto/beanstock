import 'package:flutter/material.dart';
import 'package:beanstock/core/models/product.dart';
import 'package:beanstock/core/models/store.dart';
import 'package:provider/provider.dart';
import '../models/mocks/mock_stores.dart';
import '../providers/product_provider.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late double _price;
  late String _imageUrl;
  Store? _selectedStore;
  final List<Store> stores = MockData.stores;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!.name;
      _description = widget.product!.description;
      _price = widget.product!.price;
      _imageUrl = widget.product!.imageUrl;
      if (widget.product!.stores.isNotEmpty) {
        _selectedStore = stores.firstWhere(
          (store) => store.id == widget.product!.stores.first.id,
          orElse: () => stores.first, // Caso a loja não esteja na lista, seleciona a primeira loja
        );
      }
    } else {
      _name = '';
      _description = '';
      _price = 0.0;
      _imageUrl = '';
      _selectedStore = stores.isNotEmpty ? stores[0] : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6E492F),
        title: Text(
            widget.product == null ? 'Cadastrar Produto' : 'Editar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: const TextStyle(color: Color(0xFF6E492F)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF6E492F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFCAC15F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _description,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Color(0xFF6E492F)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF6E492F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFCAC15F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _description = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _price.toString(),
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: const TextStyle(color: Color(0xFF6E492F)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF6E492F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFCAC15F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _price = double.tryParse(value) ?? 0.0;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _imageUrl,
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    labelStyle: const TextStyle(color: Color(0xFF6E492F)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF6E492F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFCAC15F)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _imageUrl = value;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButton<Store>(
                  hint: const Text("Select Store"),
                  value: _selectedStore,
                  items: stores.map((store) {
                    return DropdownMenuItem<Store>(
                      value: store,
                      child: Text(store.name),
                    );
                  }).toList(),
                  onChanged: (Store? newValue) {
                    setState(() {
                      _selectedStore = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E492F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final product = Product(
                        name: _name,
                        description: _description,
                        price: _price,
                        imageUrl: _imageUrl,
                        stores: _selectedStore != null ? [_selectedStore!] : [],
                      );

                      final provider = Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      );

                      if (widget.product == null) {
                        provider.create(product);
                      } else {
                        provider.update(widget.product!.id!, product);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.product == null
                      ? 'Add Product'
                      : 'Update Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
