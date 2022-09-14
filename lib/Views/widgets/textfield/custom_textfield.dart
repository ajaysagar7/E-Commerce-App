import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIconData;
  final Color fillColor;
  final bool? autoFocus;
  final FocusNode mainScope;
  final FocusNode? secondaryScope;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;

  final TextEditingController textEditingController;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.prefixIconData,
    required this.fillColor,
    this.autoFocus,
    required this.mainScope,
    this.secondaryScope,
    required this.textInputType,
    this.textInputAction,
    this.textAlign,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    required this.errorText,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //keyboard dismisser dependency wrap arouund body;
    return Padding(
      padding: const EdgeInsets.all(AppSize.s12),
      child: TextFormField(
        focusNode: mainScope,
        controller: textEditingController,

        // ignore: prefer_const_constructors
        toolbarOptions: ToolbarOptions(copy: true, paste: true, cut: true),

        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: textInputType,
        style: getRegularStyle(color: Colors.black),

        onFieldSubmitted: ((value) {
          mainScope.unfocus();
          secondaryScope != null
              ? FocusScope.of(context).requestFocus(secondaryScope)
              : null;
        }),
        validator: validator,
        onChanged: onChanged,

        autofocus: autoFocus ?? false,
        keyboardAppearance: Brightness.light,
        cursorColor: Colors.black,
        enabled: true,
        maxLines: 1,
        showCursor: true,

        textAlign: textAlign ?? TextAlign.start,

        //* decoration of textfield
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.all(AppPadding.p12),
          prefixIcon: Icon(prefixIconData),
          errorText: errorText,
          labelText: labelText,
          hintText: hintText,
          hintMaxLines: 1,
        ),
      ),
    );
  }
}
