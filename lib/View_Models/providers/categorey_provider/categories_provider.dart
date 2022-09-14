import 'package:flutter/cupertino.dart';
import 'package:shopping_app/Models/categories/categories.dart';
import 'package:shopping_app/Repositoy/Api%20Client/api_client.dart';

enum CategoryState { inital, loading, loaded, failed }

class CategoreisProvider with ChangeNotifier {
  CategoreisProvider() {
    getCategoreis();
  }
  List<Categories> _categoreis = [];

  List<Categories> get categoriesList => _categoreis;

  CategoryState _state = CategoryState.inital;
  CategoryState get state => _state;

  String? _error;
  String? get error => _error;

  Future<List<Categories>> getCategoreis() async {
    _categoreis.clear();
    _state = CategoryState.loading;
    notifyListeners();
    try {
      // Future.delayed(const Duration(milliseconds: 600));
      _categoreis = await ApiClient().getAllCategories();
      _state = CategoryState.loaded;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _state = CategoryState.failed;
      notifyListeners();
    }

    return _categoreis;
  }
}
