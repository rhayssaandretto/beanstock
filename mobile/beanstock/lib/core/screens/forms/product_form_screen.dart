import 'package:flutter/material.dart';
import 'package:beanstock/core/models/product.dart';
import 'package:beanstock/core/models/store.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/mocks/mock_stores.dart';
import '../../providers/product_provider.dart';
import '../../validators.dart';
import 'widgets/store_dropdown.dart';
import 'widgets/submit_button.dart';
import 'widgets/text_field.dart';

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
  late final ProductProvider _productProvider;
  final List<Store> stores = MockData.stores;

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  void _initializeFormFields() {
    final product = widget.product;
    _id = product?.id ?? '';
    _name = product?.name ?? '';
    _description = product?.description ?? '';
    _price = product?.price ?? 0.0;
    _imageUrl = product?.imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.product == null ? 'Cadastrar Produto' : 'Editar Produto',
          style: TextStyle(color: primaryBrownColor),
        ),
      ),
      backgroundColor: lightBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'ID do Produto',
                  initialValue: _id,
                  enabled: widget.product == null,
                  onChanged: (value) => _id = value,
                  validator: Validators.idValidator,
                ),
                CustomTextField(
                  label: 'Nome do Produto',
                  initialValue: _name,
                  onChanged: (value) => _name = value,
                  validator: Validators.nameValidator,
                ),
                CustomTextField(
                  label: 'Descrição',
                  initialValue: _description,
                  onChanged: (value) => _description = value,
                  validator: Validators.descriptionValidator,
                ),
                CustomTextField(
                  label: 'Preço',
                  initialValue: _price.toString(),
                  onChanged: (value) => _price = double.tryParse(value) ?? 0.0,
                  keyboardType: TextInputType.number,
                  validator: Validators.priceValidator,
                ),
                CustomTextField(
                  label: 'URL da Imagem',
                  initialValue: _imageUrl,
                  onChanged: (value) => _imageUrl = value,
                  validator: Validators.imageUrlValidator,
                ),
                const SizedBox(height: 20),
                StoreDropdown(
                  stores: stores,
                  selectedStore: _selectedStore,
                  onChanged: (store) => setState(() => _selectedStore = store),
                ),
                const SizedBox(height: 20),
                SubmitButton(
                  onPressed: _submitForm,
                  label: widget.product == null
                      ? 'Adicionar Produto'
                      : 'Atualizar Produto',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final product = Product(
        id: _id.isNotEmpty ? _id : null,
        name: _name,
        description: _description,
        price: _price,
        imageUrl: _imageUrl,
        stores: _selectedStore != null ? [_selectedStore!] : [],
      );

      try {
        if (widget.product == null) {
          await _productProvider.create(product);
          _showSnackBar("Produto adicionado com sucesso!");
        } else {
          await _productProvider.update(widget.product!.id!, product);
          _showSnackBar("Produto atualizado com sucesso!");
        }
        Navigator.pop(context);
      } catch (error) {
        _showSnackBar("Ocorreu um erro. Tente novamente.");
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
