import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTextField extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hinttext;
  final String? labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool? obscureText;
  final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    this.height,
    this.width,
    this.hinttext,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.child,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.validator,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      height: height ?? 50,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 1.0),
            blurRadius: 4.0,
          ),
        ],
        border: Border.all(color: Colors.black12),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obscureText ?? false,
          validator: validator,
          keyboardType: keyboardType,
          readOnly: readOnly,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hinttext,
            labelText: labelText,
            hintStyle: context.textTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.normal),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
