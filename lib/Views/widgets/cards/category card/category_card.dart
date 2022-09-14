import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/View_Models/providers/categorey_provider/categories_provider.dart';

import '../../../constants/app_constants.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  const CategoryCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<CategoreisProvider>();
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s12),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.clamp,
                  colors: [
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  ])),
          child: Center(
              child: AutoSizeText(
            model.categoriesList[index].name,
            style: getBoldStyle(color: Colors.white),
          )),
        ),
        // Positioned(
        //     bottom: 50,
        //     child: FancyShimmerImage(
        //         height: 80,
        //         width: 80,
        //         boxFit: BoxFit.cover,
        //         imageUrl: model.categoriesList[index].image.toString())),
        // Positioned(
        //   bottom: 50,
        //   child: Image.network(
        //     model.categoriesList[index].image,
        //     height: 80,
        //     width: 80,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // Positioned(
        //     bottom: 20,
        //     child: Text(
        //       model.categoriesList[index].name,
        //       style: getBoldStyle(color: Colors.white),
        //     )),
      ],
    );
  }
}
