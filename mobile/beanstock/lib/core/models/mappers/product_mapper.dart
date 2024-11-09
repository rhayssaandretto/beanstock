import '../product.dart';
import '../store.dart';

class ProductMapper {
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'], // Inclua o mapeamento do id aqui

      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      stores: (json['stores'] as List<dynamic>)
          .map((storeJson) => Store(
                id: storeJson['id'],
                name: storeJson['name'],
              ))
          .toList(),
    );
  }

  static Map<String, dynamic> toJson(Product product) {
    return {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'stores': product.stores
          .map((store) => {
                'id': store.id,
                'name': store.name,
              })
          .toList(),
    };
  }

  static List<Product> toList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}
