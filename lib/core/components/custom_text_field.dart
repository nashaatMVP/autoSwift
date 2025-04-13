import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.type,
    this.prefix,
    this.maxLength,
  });
  final TextEditingController controller;
  final String hint;
  final TextInputType type;
  final Widget? prefix;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: hint,
      keyboardType: type,
      suffix: prefix,
      maxLength: maxLength,
      placeholderStyle: TextStyle(fontSize: 15,color: Colors.grey),
    );
  }
}
