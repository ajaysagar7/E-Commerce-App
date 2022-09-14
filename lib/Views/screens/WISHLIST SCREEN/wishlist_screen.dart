import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Models/wishlist%20model/wishlist_model.dart';
import 'package:shopping_app/View_Models/providers/wishlist_provider/wishlist_provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WishListProvider>().getAllWishLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Consumer<WishListProvider>(builder: ((context, value, child) {
        if (value.state == WishListState.loaded) {
          return value.wishList.isEmpty
              ? const Center(
                  child: Text("Wishlist is empty"),
                )
              : ListView.builder(
                  itemCount: value.wishList.length,
                  itemBuilder: (c, i) {
                    WishlistModel wishlistModel = value.wishList[i];
                    return SizedBox(
                      height: 60.h,
                      width: double.infinity,
                      child: Card(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        child: ListTile(
                          title: Text(wishlistModel.id.toString()),
                          subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: Text(
                                  wishlistModel.productName,
                                  maxLines: 1,
                                )),
                                Flexible(
                                    child: Text(
                                  wishlistModel.productId.toString(),
                                  maxLines: 1,
                                )),
                              ]),
                        ),
                      ),
                    );
                  },
                );
        } else if (value.state == WishListState.failed) {
          return const Center(
            child: Text("something went wrong"),
          );
        } else if (value.state == WishListState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      })),
    );
  }
}
