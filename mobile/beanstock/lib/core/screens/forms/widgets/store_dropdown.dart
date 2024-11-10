import 'package:beanstock/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:beanstock/core/models/store.dart';

class StoreDropdown extends StatelessWidget {
  final List<Store> stores;
  final Store? selectedStore;
  final ValueChanged<Store?> onChanged;

  const StoreDropdown({
    super.key,
    required this.stores,
    this.selectedStore,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Store>(
      value: selectedStore,
      hint:
          Text("Selecione a loja", style: TextStyle(color: primaryBrownColor)),
      items: stores.map((store) {
        return DropdownMenuItem<Store>(
          value: store,
          child: Text(store.name),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryBrownColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryBrownColor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: activeTabBorderYellowColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
