import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  bool? loading;
  Color? backgroundColor;
  Color? textColor;
  CustomButton({
    Key? key,
    required this.callback,
    required this.title,
    this.loading,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity - 40,
      child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
              foregroundColor: textColor ?? Colors.white,
              backgroundColor: backgroundColor ?? AppColors.primary),
          child: loading!
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: getSemiBoldStyle(color: Colors.white),
                )),
    );
  }
}
