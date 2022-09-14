import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomOpenContainer extends StatelessWidget {
  final Widget closeWidget;
  final Widget openWidget;
  const CustomOpenContainer({
    Key? key,
    required this.closeWidget,
    required this.openWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        transitionDuration: const Duration(milliseconds: 800),
        tappable: true,
        // closedElevation: 0,
        // closedColor: Colors.white,
        // transitionType: ContainerTransitionType.fade,
        closedBuilder: ((context, action) => closeWidget),
        openBuilder: ((context, action) => openWidget));
  }
}
