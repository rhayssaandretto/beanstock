import 'package:beanstock/core/models/mappers/product_mapper.dart';
import 'package:beanstock/core/models/product.dart';
import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  Future<List<Product>> fetchAll() async {
    try {
      final response = await dio.get('/products');

      if (response.statusCode == 200) {
        return ProductMapper.toList(response.data);
      } else {
        throw Exception(
            'Falha ao carregar produtos. Código: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Erro ao fazer a requisição: ${e.message}');
    }
  }

  Future<Product> create(Product product) async {
    try {
      final response =
          await dio.post('/products', data: ProductMapper.toJson(product));

      if (response.statusCode == 201) {
        return ProductMapper.fromJson(response.data);
      } else {
        throw Exception(
            'Falha ao adicionar produto. Código: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Erro ao fazer a requisição: ${e.message}');
    }
  }

  Future<Product> update(String id, Product product) async {
    try {
      final response =
          await dio.put('/products/$id', data: ProductMapper.toJson(product));

      if (response.statusCode == 200) {
        print('Produto atualizado: ${response.data}');

        return ProductMapper.fromJson(response.data);
      } else {
        throw Exception(
            'Falha ao atualizar produto. Código: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Erro ao fazer a requisição: ${e.message}');
    }
  }

  Future<void> delete(String id) async {
    try {
      final response = await dio.delete('/products/$id');
      

      // if (response.statusCode != 200) {
      //   throw Exception(
      //       'Falha ao deletar produto. Código: ${response.statusCode}');
      // }
    } on DioException catch (e) {
      throw Exception('Erro ao fazer a requisição: ${e.message}');
    }
  }
}
