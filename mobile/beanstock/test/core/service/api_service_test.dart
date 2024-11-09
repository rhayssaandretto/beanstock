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
    apiService = ApiService()..dio = dioMock;
  });

  group('ApiService Tests', () {
    test(
        'fetchAll should return a list of products when response is successful',
        () async {
      // Arrange
      final productData = [
        {
          'name': 'Café',
          'description': 'Café forte',
          'price': 5.0,
          'imageUrl': 'http://example.com/cafe.jpg',
          'stores': [],
        },
      ];

      when(() => dioMock.get('/products')).thenAnswer(
        (_) async => Response(
          data: productData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/products'),
        ),
      );

      // Act
      final result = await apiService.fetchAll();

      // Assert
      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      expect(result[0].name, 'Café');
    });

    test('fetchAll should throw an exception when response is not 200',
        () async {
      // Arrange
      when(() => dioMock.get('/products')).thenAnswer((_) async => Response(
          data: {},
          statusCode: 404,
          requestOptions: RequestOptions(path: '/products')));

      // Act & Assert
      expect(() => apiService.fetchAll(), throwsException);
    });

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

    test('update should return a updated product when response is successful',
        () async {
      // Arrange
      final product = Product(
          id: '1',
          name: 'Café',
          description: 'Café forte',
          price: 5.0,
          imageUrl: 'http://example.com/cafe.jpg',
          stores: []);
      when(() => dioMock.put('/products/1', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
              data: ProductMapper.toJson(product),
              statusCode: 200,
              requestOptions: RequestOptions(path: '/products/1')));

      // Act
      final result = await apiService.update('1', product);
      expect(result.id, product.id);
      expect(result.name, product.name);
      expect(result.description, product.description);
      expect(result.price, product.price);
      expect(result.imageUrl, product.imageUrl);
      expect(result.stores, product.stores);
    });

    test('delete should complete successfully when response is 204', () async {
      // Arrange
      when(() => dioMock.delete('/products/1')).thenAnswer((_) async =>
          Response(
              statusCode: 204,
              requestOptions: RequestOptions(path: '/products/1')));

      // Act
      await apiService.delete('1');
    });

    test('delete should throw an exception when response is not 204', () async {
      // Arrange
      when(() => dioMock.delete('/products/1')).thenAnswer((_) async =>
          Response(
              statusCode: 400,
              requestOptions: RequestOptions(path: '/products/1')));

      // Act & Assert
      expect(() => apiService.delete('1'), throwsException);
    });
  });
}
