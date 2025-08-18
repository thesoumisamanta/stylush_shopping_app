import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/models/fake_store_model.dart';
import 'package:stylush_shopping_app/models/products_model.dart';
import 'package:stylush_shopping_app/services/api_services.dart';

class ProductProvider with ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  List<FakeStoreModel> _fakeProducts = [];
  List<ProductsModel> _dummyProducts = [];
  ProductsModel? _selectedproduct;

  bool _isLoading = false;
  String? _errorMessage;

  List<FakeStoreModel> get fakeProducts => _fakeProducts;
  List<ProductsModel> get dummyProducts => _dummyProducts;
  ProductsModel? get selectedProduct => _selectedproduct;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setSelectedProduct(ProductsModel product){
    _selectedproduct = product;
    notifyListeners();
  }

  void clearSelectedProduct(){
    _selectedproduct = null;
    notifyListeners();
  }

  Future<void> loadAllData() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final results = await Future.wait([
        _apiServices.fetchFakeStoreProducts(),
        _apiServices.getDummyProducts(),
      ]);
      _fakeProducts = results[0] as List<FakeStoreModel>;
      _dummyProducts = results[1] as List<ProductsModel>;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await loadAllData();
  }
}
