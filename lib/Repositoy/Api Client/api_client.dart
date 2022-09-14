import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/Models/api%20model/api_model.dart';
import 'package:shopping_app/Models/categories/categories.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/Repositoy/Api%20Exceptions/api_exceptions.dart';

class ApiClient {
  Future<List<Categories>> getAllCategories() async {
    var uri = "https://api.escuelajs.co/api/v1/categories";
    List<Categories> categories = [];
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        for (Map i in jsonData) {
          Categories model =
              Categories(id: i["id"], name: i["name"], image: i["name"]);
          categories.add(model);
          // print(categories.toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return categories;
  }

  Future<ApiModel> getSingleProductModel(int? id) async {
    ApiModel? model;
    var url = "https://api.escuelajs.co/api/v1/products/$id";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        model = ApiModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return model!;
  }

  Future<List<ApiModel>> getModels({
    String? query,
    required int offset,
    required int limit,
  }) async {
    var uri =
        "https://api.escuelajs.co/api/v1/products?offset=$offset&limit=$limit";
    List<ApiModel> apiModels = [];
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        apiModels = data.map((e) => ApiModel.fromJson(e)).toList();

        if (query!.length > 2) {
          apiModels = apiModels
              .where((element) =>
                  element.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
        } else {
          debugPrint("filtering data failed");
        }

        // for (Map i in data) {
        //   ApiModel apiModel = ApiModel(
        //       id: i["id"],
        //       category: i["category"],
        //       description: i["description"],
        //       images: i["images"],
        //       price: i["prices"],
        //       title: i["title"]);
        //   apiModels.add(apiModel);
        //   debugPrint(apiModels.toString());
        // }
      }
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
    }
    return apiModels;
  }
}
