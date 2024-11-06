// import '../../../core/models/product.dart';

// abstract interface class IProductsService {
//   Future<List<Product>> fetchAll();
//   Future<Product> create(Product product);
//   Future<Product> update(Product product, String id);
//   Future<void> delete(String id);
// }

// final class ProductsService implements IProductsService {
//   final IHttpClient httpClient;
//   const ProductsService(this.httpService);

//   @override
//   Future<List<Product>> fetchAll() async {
//     try {
//       final response = await httpClient.get('/products');
//       return response.toSucces() ? (response)
//     }catch (_) {
//      rethrow;
//     }
//   } 
// }
