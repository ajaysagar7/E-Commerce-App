import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/Models/api%20model/api_model.dart';
import 'package:shopping_app/View_Models/providers/wishlist_provider/wishlist_provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.apiModel,
    required this.callback,
    required this.isWishListed,
    required this.id,
  }) : super(key: key);

  final ApiModel apiModel;
  final VoidCallback callback;
  final bool isWishListed;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* image widget
          SizedBox(
            height: 120.h,
            width: double.infinity,
            child: Stack(
              // fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: FancyShimmerImage(
                    height: 120.h,
                    imageUrl: apiModel.category.image,
                  ),
                ),
                Positioned(
                  right: 5.w,
                  top: 5.h,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    child: IconButton(
                      icon: Icon(
                        isWishListed
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color: isWishListed ? Colors.red : Colors.black,
                      ),
                      onPressed: callback,
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: 10.h,
          // ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* price widget
                  Flexible(
                    child: AutoSizeText(
                      "\$${apiModel.price}",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //* name widget
                  Flexible(
                    child: AutoSizeText(
                      apiModel.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
