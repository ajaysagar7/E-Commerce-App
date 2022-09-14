import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../../Models/cart model/card_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cartss.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY , cartItemName TEXT,cartItemPrice TEXT,cartItemId TEXT, cartItemImage TEXT, cartItemQuantity TEXT)');
  }

  Future<CartModel> insert(CartModel cart) async {
    var dbClient = await db;
    await dbClient!.insert('cart', cart.toJson());
    return cart;
  }

  Future<List<CartModel>> getCartModelList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(CartModel cart) async {
    var dbClient = await db;
    return await dbClient!
        .update('cart', cart.toJson(), where: 'id = ?', whereArgs: [cart.id]);
  }
}
