// ignore_for_file: iterable_contains_unrelated_type

import 'package:animations/animations.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Models/api%20model/api_model.dart';
import 'package:shopping_app/Models/cart%20model/card_model.dart';
import 'package:shopping_app/Models/wishlist%20model/wishlist_model.dart';
import 'package:shopping_app/View_Models/providers/cart%20provider/cart_provider.dart';
import 'package:shopping_app/View_Models/providers/products_provider/products_provider.dart';
import 'package:shopping_app/View_Models/providers/wishlist_provider/wishlist_provider.dart';
import 'package:shopping_app/Views/constants/app_constants.dart';
import 'package:shopping_app/Views/screens/AllProduct/all_products.dart';
import 'package:shopping_app/Views/screens/CART%20SCREEN/cart_screen.dart';
import 'package:shopping_app/Views/screens/Category%20Screen/category_screen.dart';
import 'package:shopping_app/Views/screens/Details%20Screen/details_screen.dart';
import 'package:shopping_app/Views/screens/WISHLIST%20SCREEN/wishlist_screen.dart';
import 'package:shopping_app/Views/screens/search_screen/search_screen.dart';
import 'package:shopping_app/Views/widgets/cards/swiper%20card/custom_swiper_widget.dart';

import '../../widgets/cards/product card/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  late ScrollController scrollController;
  late FocusNode searchFocusNode;
  late List<CartModel> cartLIst;

  @override
  void initState() {
    searchController = TextEditingController();
    scrollController = ScrollController();
    searchFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<ProductsProvider>().getProducstsLists(isRefreshed: false);
      context.read<WishListProvider>().getAllWishLists();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //* custom appbar widget

      appBar: AppBar(
        title: const Text(AppStrings.homeScreen),
        leading: IconButton(
          icon: const Icon(IconlyBold.category),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const CategoryScreen(),
                    type: PageTransitionType.leftToRight));
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const CartScreen(),
                        type: PageTransitionType.rightToLeft));
              },
              icon: const Icon(Icons.shopping_bag)),
          IconButton(
              onPressed: () {
                context.read<CartProvider>().deleteAllCartsFromProvider();
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to go back?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            // searchFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                //* swiper widget
                const CategorySwiperCard(),
                //* textfield search
                const CategorySearchBar(),
                // const CustomSwiperCard(),
                const CategoryCustomRowWidget(),

                SingleChildScrollView(child: homeScreenProductsWidget())
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget homeScreenProductsWidget() {
    return Consumer<ProductsProvider>(builder: (context, provider, _) {
      return AnimationLimiter(
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.producstLists.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10.0),
              itemBuilder: (c, i) {
                ApiModel model = provider.producstLists[i];
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
                      child: OpenContainer(
                        openBuilder: (context, action) =>
                            DetailScreen(apiModel: model),
                        closedBuilder:
                            (BuildContext context, void Function() action) {
                          return ProductCard(
                              apiModel: model,
                              isWishListed: provider.wishlists.contains(model)
                                  ? true
                                  : false,
                              id: i,
                              callback: () async {
                                await provider.checkWishList(model.id).then(
                                    (value) => value
                                        ? removeFromWishList(
                                            context: c, apiModel: model, id: i)
                                        : addToWishlist(
                                            apiModel: model,
                                            context: c,
                                            id: i));
                                // Fluttertoast.showToast(
                                //     msg: "button is working and logic is not");
                              });
                        },
                      ),
                    ),
                  ),
                );
              }));
    });
  }
}

void addToWishlist(
    {required ApiModel apiModel,
    required BuildContext context,
    required int id}) async {
  var provider = context.read<WishListProvider>();
  WishlistModel wishlistModel = WishlistModel(
      id: id,
      productId: apiModel.id,
      productName: apiModel.title.toString(),
      productPrice: apiModel.price,
      productImage: apiModel.category.image,
      isWishlisted: true);

  await provider
      .insertFunction(wishlistModel)
      .then((value) => Logger().d("added to wishlit successfully"))
      .catchError((er, stack) => Logger().d(er.toString()));
}

void removeFromWishList(
    {required int id,
    required ApiModel apiModel,
    required BuildContext context}) async {
  var provider = context.read<WishListProvider>();

  await provider.deleteFunction(id: id).then((value) => [
        Logger().d(
            "removed from wishlsit-------------------------------------------------"),
      ]);
}

class CategoryCustomRowWidget extends StatelessWidget {
  const CategoryCustomRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Latest Items",
            style: getBoldStyle(color: Colors.black),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const AllProducts(),
                        type: PageTransitionType.fade));
              },
              icon: const Icon(Icons.shop))
        ],
      ),
    );
  }
}

class CategorySearchBar extends StatelessWidget {
  const CategorySearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: CustomSearchDelegate());
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10.h, right: 20.h, left: 20.h),
        height: 60.h,
        width: double.infinity - 20.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: AppColors.primary, width: 2.w, style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Text(
              "Search by items or categorey name...",
              style: getSemiBoldStyle(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const Icon(Icons.search)
          ],
        ),
      ),
    );
  }
}

class CategorySwiperCard extends StatelessWidget {
  const CategorySwiperCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: Consumer<ProductsProvider>(builder: (c, model, _) {
        if (model.state == ProductsState.loaded) {
          return FittedBox(
              child: CustomSwiperCard(images: model.producstLists[0].images));
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      }),
    );
  }
}
