import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Models/cart%20model/card_model.dart';
import 'package:shopping_app/View_Models/providers/cart%20provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartProvider>().getCartListsssss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                context.read<CartProvider>().deleteAllCartsFromProvider();
              },
              icon: const Icon(Icons.delete))
        ]),
        body: Consumer<CartProvider>(
          builder: ((context, snapshot, child) {
            return snapshot.cartLists.isEmpty
                ? const Center(
                    child: Text("No Items in cart !!!!"),
                  )
                : ListView.builder(
                    itemCount: snapshot.cartLists.length,
                    itemBuilder: (c, i) {
                      CartModel cartModel = snapshot.cartLists[i];
                      return Card(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        child: ListTile(
                          leading: FittedBox(
                            child: SizedBox(
                                height: 80.w,
                                width: 80.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.network(
                                    cartModel.cartItemImage,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          title: Text(cartModel.cartItemName.toString()),
                          subtitle: Text(cartModel.cartItemPrice.toString()),
                        ),
                      );
                    });
          }),
        ));
  }
}
