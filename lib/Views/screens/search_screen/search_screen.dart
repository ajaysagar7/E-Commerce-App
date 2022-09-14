import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Models/api%20model/api_model.dart';
import 'package:shopping_app/View_Models/providers/products_provider/products_provider.dart';
import 'package:shopping_app/Views/screens/Details%20Screen/details_screen.dart';
import 'package:shopping_app/Views/widgets/cards/product%20card/product_card.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.length > 2
        ? Consumer<ProductsProvider>(builder: (c, model, _) {
            if (model.state == ProductsState.initial) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else if (model.state == ProductsState.failed) {
              return Center(
                child: Text(model.errorMessage.toString()),
              );
            } else if (model.state == ProductsState.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (model.state == ProductsState.loaded) {
              return searchWidget(apiModel: model.producstLists, context: c);
            } else {
              return const Text("something went wrong");
            }
          })
        : const Center(
            child: Text("Search term must be greater than 3 charcters"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }

  Widget searchWidget(
      {required List<ApiModel> apiModel, required BuildContext context}) {
    return AnimationLimiter(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (c, i) {
              return AnimationConfiguration.staggeredGrid(
                  position: i,
                  columnCount: 2,
                  child: FadeInAnimation(
                      curve: Curves.ease,
                      delay: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 800),
                        delay: const Duration(
                          milliseconds: 200,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: DetailScreen(apiModel: apiModel[i]),
                                    type: PageTransitionType.bottomToTop));
                          },
                          child: ProductCard(
                            apiModel: apiModel[i],
                            isWishListed: false,
                            callback: () {},
                            id: i,
                          ),
                        ),
                      )));
            }));
  }
}
