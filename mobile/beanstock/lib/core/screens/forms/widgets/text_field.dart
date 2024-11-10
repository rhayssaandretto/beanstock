import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.validator,
    this.enabled = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
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
}
