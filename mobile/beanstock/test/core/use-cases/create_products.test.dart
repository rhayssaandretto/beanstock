import 'package:flutter_test/flutter_test.dart';
import 'package:beanstock/core/models/product.dart';
import 'package:beanstock/core/models/mappers/product_mapper.dart';
import 'package:beanstock/core/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions();
}

void main() {
  late DioMock dioMock;
  late ApiService apiService;

  setUp(() {
    dioMock = DioMock();
    apiService = ApiService()
      ..dio = dioMock; 
  });

  group('Create UseCase Tests', () {
    test('create should return a product when response is successful',
        () async {
      // Arrange
      final product = Product(
          id: '1',
          name: 'Café',
          description: 'Café forte',
          price: 5.0,
          imageUrl: 'http://example.com/cafe.jpg',
          stores: []);
      when(() => dioMock.post('/products', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
              data: ProductMapper.toJson(product),
              statusCode: 201,
              requestOptions: RequestOptions(path: '/products')));

      // Act
      final result = await apiService.create(product);
      expect(result.name, product.name);
      expect(result.description, product.description);
      expect(result.price, product.price);
      expect(result.imageUrl, product.imageUrl);
      expect(result.stores, product.stores);
    });

    test('create should throw an exception when response is not 201', () async {
      // Arrange
      final product = Product(
          id: '1',
          name: 'Café',
          description: 'Café forte',
          price: 5.0,
          imageUrl: 'http://example.com/cafe.jpg',
          stores: []);
      when(() => dioMock.post('/products', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
              data: {},
              statusCode: 400,
              requestOptions: RequestOptions(path: '/products')));

      // Act & Assert
      expect(() => apiService.create(product), throwsException);
    });
  });
}
