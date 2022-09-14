import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/cart model/card_model.dart';

mixin DatabaseHelper {
  Database? _db;

  final String cartTableName = "Carts";
  final String cartId = "id";
  final String cartItemName = "cartItemName";
  final String cartItemId = "cartItemId";
  final String cartItemPrice = "cartItemPrice";
  final String cartItemImage = "cartItemImage";
  final String cartItemQuantity = "cartItemQuantity";

  Future<Database?> get database async {
    if (_db == null) {
      return await initDB();
    } else {
      return _db!;
    }
  }

  Future<Database> initDB() async {
    Directory dbPath = await getApplicationDocumentsDirectory();
    String dbName = "cartsss.db";
    final path = join(dbPath.path, dbName);
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db!;
  }

  //* creating table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $cartTableName($cartId INTEGER PRIMARY KEY ,$cartItemId TEXT,$cartItemImage TEXT,$cartItemName TEXT,$cartItemPrice TEXT,$cartItemQuantity TEXT)''');
  }

  Future<bool> insertCart(CartModel cartModel) async {
    final db = await database;
    try {
      await db!.insert(cartTableName, cartModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  //* delte all carts
  Future<void> delteAllCartsFromDatabase() async {
    final db = await database;
    try {
      await db!.delete(cartTableName);
    } catch (e) {
      Logger().d(e.toString());
    }
  }

  Future<List<CartModel>> getCartList() async {
    final db = await database;

    List<Map<String, dynamic>> items = await db!.query(cartTableName);

    return List.generate(
        items.length,
        (i) => CartModel(
            id: items[i]["id"],
            cartItemName: items[i]["cartItemName"],
            cartItemPrice: items[i]["cartItemPrice"],
            cartItemId: items[i]["cartItemId"],
            cartItemImage: items[i]["cartItemImage"],
            cartItemQuantity: items[i]["cartItemQuantity"]));
  }

  //* delete function

  Future<void> deleteCartFromDatabase({required int id}) async {
    final db = await database;
    try {
      await db!.delete(cartTableName, where: "id == ?", whereArgs: [id]);
      debugPrint("delete cart from database");
      Logger().d(
          "deleted Cart-item from database--------------------------------------------------------------------------------");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
