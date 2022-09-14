import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  IconData? firstIcondata;
  Function? firstFunction;
  IconData? leadingIconData;
  VoidCallback? leadingFunction;
  IconData? secondIcondata;
  Function? secondFunction;
  bool? isAlwaysLeading;

  CustomAppBar({
    Key? key,
    required this.title,
    this.firstIcondata,
    this.firstFunction,
    this.leadingIconData,
    this.leadingFunction,
    this.secondIcondata,
    this.secondFunction,
    this.isAlwaysLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isAlwaysLeading != null ? true : false,
      title: Text(title),
      leading: leadingIconData != null
          ? IconButton(
              icon: Icon(leadingIconData),
              onPressed: () => leadingFunction,
            )
          : Container(),
      actions: [
        firstIcondata != null
            ? IconButton(
                onPressed: () => firstFunction, icon: Icon(firstIcondata))
            : Container(),
        secondIcondata != null
            ? IconButton(
                onPressed: () => secondFunction, icon: Icon(secondIcondata))
            : Container(),
      ],
    );
  }
}
