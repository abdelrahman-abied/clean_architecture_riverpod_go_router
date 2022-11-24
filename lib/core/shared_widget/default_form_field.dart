import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import '../theme/style.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final Widget? label;
  final String? Function(String? s) validatorFunction;
  final bool isPassword;
  final IconData? prefixIcon;
  final AutovalidateMode validateMode;
  final IconData? suffixIcon;
  final VoidCallback? suffixPressed;
  final bool autofocus;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String s)? onFieldSubmitted;
  final bool? enable;
  final double height;
  const DefaultFormField({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    required this.validatorFunction,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixPressed,
    this.autofocus = false,
    this.validateMode = AutovalidateMode.disabled,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.enable,
    this.height = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        enabled: enable,
        obscureText: isPassword,
        controller: controller,
        autofocus: autofocus,
        focusNode: focusNode,
        textInputAction: textInputAction,
        autovalidateMode: validateMode,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          fillColor: Colors.white,
          // filled: true,
          isDense: true,
          errorStyle: const TextStyle(
            color: errorColor,
          ),
          hintStyle: const TextStyle(fontSize: 14),
          label: label,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: formFieldBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: formFieldBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: formFieldBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: errorColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffixIcon,
                    color: primaryColor,
                  ),
                )
              : null,
          hintText: hint,
        ),
        validator: validatorFunction,
        maxLines: null,
        expands: true,
      ),
    );
  }
}
