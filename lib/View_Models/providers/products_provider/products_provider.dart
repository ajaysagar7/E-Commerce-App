import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shopping_app/Models/api%20model/api_model.dart';
import 'package:shopping_app/Models/wishlist%20model/wishlist_model.dart';
import 'package:shopping_app/Repositoy/Api%20Client/api_client.dart';

enum ProductsState {
  initial,
  loading,
  loaded,
  failed;
}

enum SingleState { inital, loading, loaded, failed }

class ProductsProvider with ChangeNotifier {
  String? _error;
  String? get errorMessage => _error;
  String? _singleError;
  String? get singleError => _singleError;

  List<WishlistModel> _wishlists = [];
  List<WishlistModel> get wishlists => _wishlists;

  void updateWishList({required List<WishlistModel> updatedList}) {
    if (updatedList.isNotEmpty) {
      _wishlists = updatedList;
      notifyListeners();
    }
  }

  List<ApiModel> _productsList = [];
  List<ApiModel> get producstLists => _productsList;
  ApiModel? _singleProductModel;
  ApiModel? get singleProduct => _singleProductModel!;
  ProductsState _state = ProductsState.initial;
  ProductsState get state => _state;

  SingleState _singleState = SingleState.inital;
  SingleState get singleState => _singleState;


  late int _productLimit = 10;
  late int _productOffset = 0;

  //* all products function

  Future<List<ApiModel>> getProducstsLists(
      {String? query, required bool isRefreshed}) async {
    Future.delayed(const Duration(seconds: 3));
    _state = ProductsState.loading;
    try {


      List<ApiModel> data = await ApiClient()
          .getModels(limit: _productLimit, offset: _productOffset);

      if (!isRefreshed) {
        _productsList = data;
        _state = ProductsState.loaded;
      } else {
        _productLimit += 10;
        _productOffset += 0;
        _productsList.addAll(data);
        _state = ProductsState.loaded;
      }
    } catch (e) {
      debugPrint(e.toString());
      _error = e.toString();
      Fluttertoast.showToast(msg: "fetching products failed");
      _state = ProductsState.failed;
    }
    notifyListeners();

    return _productsList;
  }

  //* single products
  Future<ApiModel> getSingleProduct(int id) async {
    _singleState = SingleState.loading;
    notifyListeners();
    try {
      Future.delayed(const Duration(seconds: 2));
      ApiModel model = await ApiClient().getSingleProductModel(id);
      _singleProductModel = model;
      _singleState = SingleState.loaded;
      notifyListeners();
    } catch (e) {
      _singleError = e.toString();
      _singleState = SingleState.failed;
      notifyListeners();
    }
    return _singleProductModel!;
  }

  Future<bool> checkWishList(int id) async {
    if (_wishlists.where((element) => element.id == id).isNotEmpty) {
      notifyListeners();
      Logger().d(
          "Already Available in the list---------------------------------------------------");
      return true;
    } else {
      notifyListeners();
      Logger().d("Not available in the list-------------------------------");
      // debugPrint(
      //     "not available in the lsit-----------------------------------------------------------");
      return false;
    }
  }
}
