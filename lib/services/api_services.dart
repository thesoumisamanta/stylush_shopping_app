import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stylush_shopping_app/connections/api_connections.dart';
import 'package:stylush_shopping_app/models/fake_store_model.dart';
import 'package:stylush_shopping_app/models/products_model.dart';

class ApiServices {
  Future<List<ProductsModel>> getDummyProducts() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConnections.dummyProductsUrl),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> productsJson = data['products'];
        return productsJson
            .map((json) => ProductsModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<FakeStoreModel>> fetchFakeStoreProducts() async {
    try {
      final response = await http.get(Uri.parse(ApiConnections.fakeProductUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => FakeStoreModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products details');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
