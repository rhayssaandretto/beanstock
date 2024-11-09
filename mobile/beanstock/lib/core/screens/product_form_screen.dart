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
  late String _id, _name, _description, _imageUrl;
  late double _price;
  Store? _selectedStore;
  final List<Store> stores = MockData.stores;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _initializeProduct(widget.product!);
    } else {
      _initializeEmptyProduct();
    }
  }

  void _initializeProduct(Product product) {
    _id = product.id!;
    _name = product.name;
    _description = product.description;
    _price = product.price;
    _imageUrl = product.imageUrl;
  }

  void _initializeEmptyProduct() {
    _id = '';
    _name = '';
    _description = '';
    _price = 0.0;
    _imageUrl = '';
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
                _buildTextField(
                  label: 'Product ID',
                  initialValue: _id,
                  enabled: widget.product == null,
                  onChanged: (value) => _id = value,
                  validator: _idValidator,
                ),
                _buildTextField(
                  label: 'Product Name',
                  initialValue: _name,
                  onChanged: (value) => _name = value,
                  validator: _nameValidator,
                ),
                _buildTextField(
                  label: 'Description',
                  initialValue: _description,
                  onChanged: (value) => _description = value,
                  validator: _descriptionValidator,
                ),
                _buildTextField(
                  label: 'Price',
                  initialValue: _price.toString(),
                  onChanged: (value) => _price = double.tryParse(value) ?? 0.0,
                  keyboardType: TextInputType.number,
                  validator: _priceValidator,
                ),
                _buildTextField(
                  label: 'Image URL',
                  initialValue: _imageUrl,
                  onChanged: (value) => _imageUrl = value,
                  validator: _imageUrlValidator,
                ),
                const SizedBox(height: 20),
                _buildStoreDropdown(),
                const SizedBox(height: 20),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    String? Function(String?)? validator,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
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
        enabled: enabled,
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildStoreDropdown() {
    return DropdownButtonFormField<Store>(
      value: _selectedStore,
      hint: const Text("Select Store"),
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
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCAC15F)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6E492F),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: _submitForm,
      child: Text(widget.product == null ? 'Add Product' : 'Update Product'),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: _id.isNotEmpty ? _id : null,
        name: _name,
        description: _description,
        price: _price,
        imageUrl: _imageUrl,
        stores: _selectedStore != null ? [_selectedStore!] : [],
      );

      final provider = Provider.of<ProductProvider>(context, listen: false);

      if (widget.product == null) {
        await provider.create(product);
      } else {
        await provider.update(widget.product!.id!, product);
      }
      Navigator.pop(context);
    }
  }

  // Validators
  String? _idValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an ID';
    return null;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a name';
    return null;
  }

  String? _descriptionValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a description';
    return null;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a price';
    if (double.tryParse(value) == null) return 'Please enter a valid number';
    return null;
  }

  String? _imageUrlValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an image URL';
    return null;
  }
}
