import 'package:flutter/material.dart';

class TextInputFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final double fontSize;
  final TextAlign textAlign;
  final Function validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;

  const TextInputFormField(
      {Key key,
      this.hintText,
      this.obscureText = false,
      this.fontSize = 14,
      this.textAlign = TextAlign.center,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.textCapitalization = TextCapitalization.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFF008fe5),
          fontSize: fontSize,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white30, width: 1.0, style: BorderStyle.solid),
        ),
      ),
      textAlign: textAlign,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.words,
    );
  }
}
