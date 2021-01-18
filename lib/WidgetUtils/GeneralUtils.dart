import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header(
    this.text, {
    fontSize = 26.0,
    fontWeight = FontWeight.w500,
    color,
    margin,
    padding,
    alignment = Alignment.center,
  })  : size = fontSize,
        weight = fontWeight,
        _color = color,
        _margin = margin,
        _padding = padding,
        _alignment = alignment;

  final String text;
  final double size;
  final Color _color;
  final EdgeInsetsGeometry _padding;
  final EdgeInsetsGeometry _margin;
  final Alignment _alignment;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: _alignment,
      padding: _padding,
      margin: _margin,
      child: Text(
        text,
        style: TextStyle(fontSize: size, fontWeight: weight, color: _color),
      ),
    );
  }
}

class CenteredText extends StatelessWidget {
  final String textData;

  CenteredText(this.textData);

  @override
  Widget build(BuildContext context) {
    return Text(
      textData,
      textAlign: TextAlign.center,
    );
  }
}

class ItsOutlinedInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;

  ItsOutlinedInputField({this.controller, this.labelText, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}