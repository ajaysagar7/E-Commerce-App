import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopping_app/Models/api%20model/api_model.dart';
import 'package:shopping_app/Models/wishlist%20model/wishlist_model.dart';
import 'package:shopping_app/View_Models/functions/functiosn.dart';
import 'package:shopping_app/View_Models/providers/products_provider/products_provider.dart';
import 'package:shopping_app/View_Models/providers/wishlist_provider/wishlist_provider.dart';
import 'package:shopping_app/Views/constants/app_constants.dart';
import 'package:shopping_app/Views/screens/Details%20Screen/details_screen.dart';
import 'package:shopping_app/Views/screens/HomeScreen/home_screen.dart';
import 'package:shopping_app/Views/shimmer/product_shimmer.dart';
import 'package:shopping_app/Views/widgets/animations/open_container/open_container.dart';

import '../../widgets/cards/product card/product_card.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late ScrollController scrollController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductsProvider>().getProducstsLists(isRefreshed: false);
    });
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent) {
        await context
            .read<ProductsProvider>()
            .getProducstsLists(isRefreshed: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Products"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: const HomeScreen(),
                      type: PageTransitionType.fade));
            },
          ),
        ),
        body: Builder(builder: (c) {
          return Consumer<ProductsProvider>(builder: (c, model, _) {
            if (model.state == ProductsState.loaded) {
              return allProductsWidget();
            } else if (model.state == ProductsState.loading) {
              // return const Center(
              //   child: CircularProgressIndicator(),
              return GridView.builder(
                itemCount: 20,
                itemBuilder: ((context, index) => const ShimmerProductCard()),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10.h,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w),
              );
            } else if (model.state == ProductsState.failed) {
              return Center(
                child: Text(
                  model.errorMessage.toString(),
                  style: getBoldStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
        }));
  }

  Widget allProductsWidget() {
    var producstLists = context.watch<ProductsProvider>().producstLists;
    return AnimationLimiter(
        child: SmartRefresher(
      // onRefresh: () async {
      //   await context
      //       .read<ProductsProvider>()
      //       .getProducstsLists(isRefreshed: false);
      // },
      onLoading: () async {
        await context
            .read<ProductsProvider>()
            .getProducstsLists(isRefreshed: true)
            .then((value) => _refreshController.loadComplete())
            .onError((error, stackTrace) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString()))));
      },

      enablePullDown: false,
      enablePullUp: true,
      // footer: const Text("App made by Aj"),
      controller: _refreshController,
      child: GridView.builder(
          // controller: scrollController,
          shrinkWrap: true,
          itemCount: producstLists.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10.h, crossAxisSpacing: 10.w),
          itemBuilder: (c, i) {
            ApiModel model = producstLists[i];
            return AnimationConfiguration.staggeredGrid(
                position: i,
                columnCount: 2,
                child: SlideAnimation(
                  curve: Curves.ease,
                  verticalOffset: -20,
                  delay: const Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 800),
                  child: FadeInAnimation(
                      curve: Curves.ease,
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 800),
                      child: CustomOpenContainer(
                        closeWidget: ProductCard(
                          apiModel: model,
                          isWishListed: context
                                  .watch<ProductsProvider>()
                                  .wishlists
                                  .where((element) => element.id == i)
                                  .isNotEmpty
                              ? true
                              : false,
                          callback: () async {
                            await context
                                .read<ProductsProvider>()
                                .checkWishList(i)
                                .then((value) {
                              if (!value) {
                                removeFromWishList(
                                    id: i, apiModel: model, context: context);
                              } else {
                                addToWishlist(
                                    apiModel: model, context: context, id: i);
                              }
                            });
                          },
                          id: i,
                        ),
                        openWidget: DetailScreen(apiModel: model),
                      )),
                ));
          }),
    ));
  }
}
