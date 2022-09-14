import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_app/Models/wishlist%20model/wishlist_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseWishList {
  final String tableName = "wishlist";
  final String tableId = "id";
  final String productId = "productId";
  final String productName = "productName";
  final String productPrice = "productPrice";
  final String productImage = "productImage";
  final String isWishlisted = "isWishlisted";

  static Database? _db;
  Future<Database?> get databse async {
    if (_db != null) {
      return _db!;
    }
    return _db = await initDB();
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbName = "wishlistsssss.db";
    String path = join(directory.path, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tableName($tableId INTEGER PRIMARY KEY  ,$productId INTEGER,$productName TEXT,$productPrice INTEGER,$productImage TEXT,$isWishlisted INTEGER)''');
  }

  Future<bool> insertWishlistInDB(WishlistModel wishlistModel) async {
    final db = await databse;

    try {
      await db!.insert(tableName, wishlistModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<WishlistModel>> getWishListsFromDatabase() async {
    final db = await databse;
    List<Map<String, dynamic>> items = await db!.query(tableName);
    return List.generate(
        items.length,
        (i) => WishlistModel(
            id: items[i]["id"],
            productId: items[i]["productId"],
            productName: items[i]["productName"],
            productPrice: items[i]["productPrice"],
            productImage: items[i]["productImage"],
            isWishlisted: items[i]["isWishlisted"] == 1 ? true : false));
  }

  Future<void> deleteWishListById({required int id}) async {
    final db = await databse;
    await db!.delete(
      tableName,
      where: "id == ?",
      whereArgs: [id],
    );
  }

  Future<void> delteAllWishListInDB() async {
    final db = await databse;
    await db!
        .delete(tableName)
        .then((value) => Logger().d("all wishlists are delted sucessfully"));
  }

  Future<void> updateWishListInDB(
      {required WishlistModel wishlistModel}) async {
    final db = await databse;
    try {
      await db!.update(tableName, wishlistModel.toJson(),
          where: "id == ?",
          whereArgs: [
            wishlistModel.id
          ]).then((value) => Fluttertoast.showToast(
          msg: "wishlist updated in the local database"));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
