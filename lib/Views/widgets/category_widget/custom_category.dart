import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/View_Models/providers/categorey_provider/categories_provider.dart';
import 'package:shopping_app/Views/widgets/cards/category%20card/category_card.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<CategoreisProvider>();
    return AnimationLimiter(
      child: GridView.builder(
          itemCount: model.categoriesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
          itemBuilder: ((context, index) {
            return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                // ignore: prefer_const_constructors
                child: SlideAnimation(
                    horizontalOffset: -20,
                    curve: Curves.ease,
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 800),
                    child: FadeInAnimation(
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 800),
                        child: CategoryCard(
                          index: index,
                        ))));
          })),
    );
  }
}
