import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomStaggeredAnimation extends StatelessWidget {
  final Widget? childWidget;
  final int itemcount;
  const CustomStaggeredAnimation({
    Key? key,
    required this.childWidget,
    required this.itemcount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
          itemCount: itemcount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
          itemBuilder: ((context, index) {
            return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                // ignore: prefer_const_constructors
                child: FadeInAnimation(
                    curve: Curves.ease,
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 800),
                    child: SlideAnimation(
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 800),
                        verticalOffset: -20,
                        child: childWidget ?? Container())));
          })),
    );
  }
}
