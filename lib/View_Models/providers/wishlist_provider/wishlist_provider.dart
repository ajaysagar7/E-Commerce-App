import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shopping_app/Models/wishlist%20model/wishlist_model.dart';
import 'package:shopping_app/services/Database/wishlist_databse/wishlist_database.dart';

enum WishListState { inital, loading, loaded, failed }

class WishListProvider with ChangeNotifier, DatabaseWishList {
  List<WishlistModel> _wishLists = [];
  List<WishlistModel> get wishList => _wishLists;
  WishListState _state = WishListState.inital;
  WishListState get state => _state;

  //* get functions
  Future<List<WishlistModel>> getAllWishLists() async {
    _state = WishListState.loading;
    notifyListeners();
    try {
      await Future.delayed(const Duration(milliseconds: 2));
      _wishLists = await getWishListsFromDatabase();
      _state = WishListState.loaded;
      Fluttertoast.showToast(msg: "fetched all lists successfully");
      notifyListeners();
    } catch (e) {
      _state = WishListState.failed;

      debugPrint(e.toString());
      notifyListeners();
    }
    return _wishLists;
  }

  // //* insert Function
  // Future<void> insertWishList({required WishlistModel wishlistModel}) async {
  //   try {
  //     if (!_wishLists.contains(wishlistModel)) {
  //       await insertWishlistFromData(wishlistModel).then((value) {
  //         debugPrint(
  //             "successfully added to wishlist----------------------------------------------");
  //         notifyListeners();
  //         return true;
  //       });
  //     } else {
  //       Fluttertoast.showToast(msg: "already available in the list");
  //     }
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // Future<bool> getBoolValue(int product) async {
  //   try {
  //     _wishLists
  //         .indexWhere((element) => int.parse(element.id) == product);
  //     return true;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return false;
  //   }
  // }

  // Future<void> addOrRemoveWishlist({required WishlistModel model}) async {
  //   try {
  //     // ignore: iterable_contains_unrelated_type
  //     _wishLists.contains(model.productId) ? _insertFunction : removeFunction;
  //     notifyListeners();
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //     notifyListeners();
  //   }
  // }

  Future<void> insertFunction(WishlistModel model) async {
    try {
      await insertWishlistInDB(model);
      notifyListeners();
      // Fluttertoast.showToast(msg: "successfully added to wishlist");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      notifyListeners();
    }
  }

  Future<void> removeFunction(WishlistModel model) async {
    try {
      await deleteWishListById(id: model.id.toInt());
      _wishLists.removeAt(model.id);

      // _wishLists.remove(model);

      Fluttertoast.showToast(msg: "removed from  wishlist");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteFunction({required int id}) async {
    try {
      await deleteWishListById(id: id).then((value) => [
            _wishLists.remove(id),
            Fluttertoast.showToast(msg: "succcessfully deleted"),
            Logger().d(
                "delted sucessfully-------------------------------------------------------------------------")
          ]);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateFunction({required WishlistModel wishlistModel}) async {
    try {
      await updateWishListInDB(wishlistModel: wishlistModel).then((value) => [
            Fluttertoast.showToast(msg: "succcessfully updated"),
            Logger().d(
                "updated sucessfully-------------------------------------------------------------------------")
          ]);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
