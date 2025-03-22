import 'package:flutter/material.dart';

class DSText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  const DSText(this.data, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}
