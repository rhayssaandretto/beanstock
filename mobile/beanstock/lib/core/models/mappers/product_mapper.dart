import '../product.dart';
import '../store.dart';

class ProductMapper {
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
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

  // Converte uma lista de mapas JSON em uma lista de objetos Product
  static List<Product> toList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}