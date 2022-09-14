import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/View_Models/providers/products_provider/products_provider.dart';
import 'package:shopping_app/Views/constants/app_constants.dart';

class CustomSwiperCard extends StatelessWidget {
  final List<String> images;
  const CustomSwiperCard({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ProductsProvider>();
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.25,
      width: size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s12),
        child: Swiper(
          allowImplicitScrolling: true,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              images[index].toString(),
              fit: BoxFit.fill,
            );
          },
          itemCount: provider.producstLists[0].images.length,

          curve: Curves.ease,

          axisDirection: AxisDirection.right,
          scrollDirection: Axis.horizontal,
          indicatorLayout: PageIndicatorLayout.NONE,
          layout: SwiperLayout.DEFAULT,
          pagination: const SwiperPagination(),
          // control: const SwiperControl(),
        ),
      ),
    );
  }
}
