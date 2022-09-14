import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/Models/api%20model/api_model.dart';
import 'package:shopping_app/Models/cart%20model/card_model.dart';
import 'package:shopping_app/View_Models/providers/cart%20provider/cart_provider.dart';
import 'package:shopping_app/View_Models/providers/products_provider/products_provider.dart';
import 'package:shopping_app/Views/constants/app_constants.dart';
import 'package:shopping_app/Views/shimmer/details_shimmer.dart';
import 'package:shopping_app/Views/widgets/buttons/custom_button.dart';
import 'package:shopping_app/Views/widgets/cards/interactive_card/interactive_card.dart';
import 'package:shopping_app/Views/widgets/cards/swiper%20card/custom_swiper_widget.dart';

class DetailScreen extends StatefulWidget {
  // final String productTitle;
  // final String productPrice;
  // final String productDescription;
  // final List<String> images;
  ApiModel apiModel;
  DetailScreen({
    Key? key,
    required this.apiModel,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiModel? model;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartProvider>().getCartList();
      context.read<ProductsProvider>().getSingleProduct(widget.apiModel.id);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CartProvider>().getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.apiModel.title),
        ),
        body: Consumer<ProductsProvider>(
          builder: (c, provider, _) {
            if (provider.singleState == SingleState.inital) {
              return const Center(
                child: Text("initial state"),
              );
            } else if (provider.singleState == SingleState.failed) {
              return Center(
                child: Text(provider.singleError.toString()),
              );
            } else if (provider.singleState == SingleState.loading) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: const ShimmerDetailsScreen(),
              );
            } else if (provider.singleState == SingleState.loaded) {
              return bodyWidget(model: provider.singleProduct);
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
          },
        ));
  }
}

class bodyWidget extends StatelessWidget {
  const bodyWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ApiModel? model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                model!.title,
                style: getBoldStyle(color: Colors.black),
              ),
            ),
            Expanded(
              child: Text(
                "\$${model!.price.toString()}",
                textAlign: TextAlign.end,
                style: getBoldStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: CustomInteractiveCard(
                        images: model!.images,
                      ),
                      type: PageTransitionType.fade));
            },
            child: Hero(
                tag: "hero",
                child: CustomSwiperCard(
                  images: model!.images,
                ))),
        const SizedBox(
          height: 20.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model!.description,
              style: getBoldStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: getRegularStyle(
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                addToCartButton(model!),
                const SizedBox(
                  height: 10.0,
                ),
                CustomButton(
                  callback: () {},
                  title: "Buy Now",
                  loading: false,
                  backgroundColor: Colors.amber,
                  textColor: AppColors.primary,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  addToCartButton(ApiModel model) {
    return Builder(
        builder: (c) => Consumer<CartProvider>(
              builder: (c, cartProvider, _) {
                return CustomButton(
                    backgroundColor: cartProvider.cartLists
                            .where((element) =>
                                element.cartItemName == model.title)
                            .isNotEmpty
                        ? Colors.green
                        : Colors.black,
                    callback: () async {
                      CartModel cartModel = CartModel(
                          id: model.id,
                          cartItemName: model.title.toString(),
                          cartItemPrice: model.price.toString(),
                          cartItemId: model.id.toString(),
                          cartItemImage: model.category.image.toString(),
                          cartItemQuantity: 1.toString());

                      cartProvider.cartLists
                              .where((element) =>
                                  element.cartItemName.toLowerCase() ==
                                  model.title.toLowerCase())
                              .isNotEmpty
                          ? await cartProvider.delteCartFromProvider(
                              id: model.id)
                          : await cartProvider.addToCart(cartModel: cartModel);
                    },
                    title: cartProvider.cartLists
                            .where((element) =>
                                element.cartItemName.toLowerCase() ==
                                model.title.toLowerCase())
                            .isNotEmpty
                        ? "Added to Cart"
                        : "Add",
                    loading: cartProvider.cartLoading);
              },
            ));
  }
}
