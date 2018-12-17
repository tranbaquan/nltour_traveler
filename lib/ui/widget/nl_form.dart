import 'package:flutter/material.dart';

class TextInputForm extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final double fontSize;
  final TextAlign textAlign;

  const TextInputForm(
      {Key key,
      this.hintText,
      this.obscureText = false,
      this.fontSize = 14,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
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
    );
  }
}
