import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Models/cart%20model/card_model.dart';
import 'package:shopping_app/services/Database/database_helper.dart';

enum CartState {
  initial,
  adding,
  added,
  removing,
  removed,
  failed,
  loading,
  loaded
}

class CartProvider with ChangeNotifier, DatabaseHelper {
  CartProvider() {
    // getCartList();
  }
  // int _countValue = 0;
  // int get countValue => _countValue;

  // double _totalPrice = 0.0;
  // double get totalPrice => _totalPrice;

  CartState _cartState = CartState.initial;
  CartState get cartState => _cartState;

  bool _cartLoading = false;
  bool get cartLoading => _cartLoading;

  List<CartModel> _cartList = [];
  List<CartModel> get cartLists => _cartList;

  // void setSharePreference() async {
  //   SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  //   await sharedPreference.setInt("counterValue", _countValue);
  //   await sharedPreference.setDouble("totalprice", _totalPrice);
  //   notifyListeners();
  // }

  void getSharedPreferenes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getInt("counterValue");
    sharedPreferences.getDouble("totalprice");
    notifyListeners();
  }

  Future<void> addToCart({required CartModel cartModel}) async {
    _cartLoading = true;
    try {
      await insertCart(cartModel).then((value) {
        notifyListeners();

        _cartState = CartState.added;
        Fluttertoast.showToast(msg: "added to cart");
        _cartLoading = false;
        debugPrint(
            "added to cart sucessfullly.........................................................................");
      });
    } catch (e) {
      _cartState = CartState.failed;
      _cartLoading = false;
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<void> delteCartFromProvider({required int id}) async {
    try {
      await deleteCartFromDatabase(id: id);
      _cartList.removeAt(id);
      Fluttertoast.showToast(msg: "deleted from cart");
      notifyListeners();
    } catch (e) {
      Logger().d(e.toString());
    }
  }

  //* get cartList

  Future<List<CartModel>> getCartListsssss() async {
    _cartState = CartState.initial;
    try {
      _cartList = await getCartList();
      debugPrint(
          "cart list added.----------------------------------------------------------------------------------------------");
      _cartState = CartState.loaded;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _cartState = CartState.failed;
      notifyListeners();
    }
    return _cartList;
  }

  Future<void> deleteAllCartsFromProvider() async {
    await delteAllCartsFromDatabase();
    Fluttertoast.showToast(msg: "all items are deleted");
    notifyListeners();
  }


  Future<void> removeFromCart({required int id}) async {
    await deleteCartFromDatabase(id: id)
        .then((value) => Fluttertoast.showToast(msg: "deleted from carts"));
  }
}
