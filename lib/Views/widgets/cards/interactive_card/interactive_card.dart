import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import 'package:shopping_app/Views/constants/app_constants.dart';

class CustomInteractiveCard extends StatelessWidget {
  List<String> images;
  CustomInteractiveCard({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Swiper(
        itemCount: 3,
        autoplay: false,
        axisDirection: AxisDirection.right,
        containerHeight: size.height,
        containerWidth: size.width,
        controller: SwiperController(),
        control: const SwiperControl(
            color: Colors.white,
            disableColor: Colors.black,
            padding: EdgeInsets.all(AppSize.s12),
            iconPrevious: Icons.arrow_back_ios_new),
        itemBuilder: (c, i) {
          return Hero(
              tag: "hero",
              child: FancyShimmerImage(
                imageUrl: images[i].toString(),
              ));
        },
      ),
    );
  }
}
