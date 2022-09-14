import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopping_app/Repositoy/Api%20Exceptions/api_exceptions.dart';

import '../../Models/api model/api_model.dart';

class DioClient {
  // final Dio _dio = Dio(

  // );
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'https://reqres.in/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors;

  //* getAllProducts
  Future<List<ApiModel>> getModelsUsingDio({
    String? query,
    required int offset,
    required int limit,
  }) async {
    List<ApiModel> apiModel = [];
    try {
      final response = await _dio.get(
          "https://api.escuelajs.co/api/v1/products?offset=$offset&limit=$limit");

      if (response.statusCode == 200) {
        final List data = await response.data;
        apiModel = data.map((e) => ApiModel.fromJson(e)).toList();
        Logger().d(apiModel.toString());
        debugPrint(apiModel.toString());

        if (query!.length > 2) {
          apiModel = apiModel
              .where((element) =>
                  element.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
        } else {
          debugPrint("filtering data failed");
        }

        // for (Map i in data) {
        //   ApiModel dataModel = ApiModel(
        //       id: i["id"],
        //       title: i["title"],
        //       price: i["price"],
        //       description: i["description"],
        //       category: i["category"],
        //       images: i["images"]);

        //   apiModel.add(dataModel);
        // }
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      Logger().d(errorMessage);
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
    return apiModel;
  }
}
