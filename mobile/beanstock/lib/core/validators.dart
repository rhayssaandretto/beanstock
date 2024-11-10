class Validators {
  static String? idValidator(String? value) =>
      (value == null || value.isEmpty) ? 'Please enter an ID' : null;

  static String? nameValidator(String? value) =>
      (value == null || value.isEmpty) ? 'Please enter a name' : null;

  static String? descriptionValidator(String? value) =>
      (value == null || value.isEmpty) ? 'Please enter a description' : null;

  static String? priceValidator(String? value) => (value == null ||
          value.isEmpty)
      ? 'Please enter a price'
      : (double.tryParse(value) == null ? 'Please enter a valid number' : null);

  static String? imageUrlValidator(String? value) =>
      (value == null || value.isEmpty) ? 'Please enter an image URL' : null;
}
