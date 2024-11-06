import 'package:flutter_test/flutter_test.dart';
import 'package:beanstock/core/models/product.dart';
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

  group('Get Products Tests', () {
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
  });
}
